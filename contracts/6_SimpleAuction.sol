// SPDX-License-Identifier: MIT
pragma solidity >0.7.0 <0.9.0;

contract SimpleAuction {

    // Parameters of the SimpleAuction
    address payable public beneficiary; // This address can be used to send coins
    uint public auctionEndTime;

    // Current state of the auctionEndTime
    address public highestBidder;
    uint public highestBid;

    mapping(address => uint) public pendingReturns;

    bool ended = false;

    event HighestBidIncrease(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    constructor(uint _biddingTime, address payable _beneficiary) {
        beneficiary = _beneficiary;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    

}