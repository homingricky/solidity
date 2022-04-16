// SPDX-License-Identifier: MIT
pragma solidity >0.7.0 <0.9.0;

contract Escrow {

    enum State {NOT_INITIATED, AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE}
    State public currState;

    bool public isBuyerIn;
    bool public isSellerIn;

    uint public price;

    address payable public seller;
    address public buyer;

    modifier onlyBuyer() {require(msg.sender == buyer, "Only buyer can call this function"); _;}
    modifier onlySeller() {require(msg.sender == seller, "Only seller can call this function"); _;}
    modifier notInitiated() {require(currState != State.NOT_INITIATED); _;}

    constructor(address payable _seller, address _buyer, uint _price) {
        seller = _seller;
        buyer = _buyer;
        price = _price * (1 ether);
    }

    function initContract() public notInitiated {
        if (msg.sender == seller) { isSellerIn = true; }
        if (msg.sender == buyer) { isSellerIn = true; }
        if (isBuyerIn && isSellerIn) { currState = State.AWAITING_PAYMENT; }
    }

    function deposit() public payable onlyBuyer {
        require(currState == State.AWAITING_PAYMENT, "Payment can't be made at this stage");
        require(msg.value == price, "Deposit amount does not match with price");
        currState = State.AWAITING_DELIVERY;
    }

    // Transfer the fund to the seller
    function confirmDelivery() public payable onlyBuyer {
        require(currState == State.AWAITING_DELIVERY, "Delivery can't be made at this stage");
        seller.transfer(price);
        currState = State.COMPLETE;
    }

    function withdraw() public payable onlyBuyer{
        require(currState == State.AWAITING_DELIVERY, "Withdrawal can't be made at this stage");
        payable(buyer).transfer(price);
        currState = State.COMPLETE;
    }

}