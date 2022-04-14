// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract myContract {
    uint public myUint = 1;
    int public myInt = -1;
    string public mystring = "myString";
    bool public myBool = true;
    // constant keyword can be added to tell solidity that the variable cannot be modified
}

contract myGame {

    uint public playerCount = 0;
    mapping (address => Player) public players;
    //Player[] public players; // An array of Player type named players


    //Just like list, enum is also index-based
    //Novice =0, Intermediate =1, Advanced=2
    enum Level {Novice, Intermediate, Advanced} 

    struct Player {
        address playerAddress;
        Level playerLevel;
        string firstName;
        string lastName;
    }

    function addPlayer(string memory firstName, string memory lastName) public {
        //players.push(Player(firstName, lastName));
        players[msg.sender] = Player(msg.sender,Level.Novice,firstName, lastName);
        playerCount += 1;
    }

    function getPlayerLevel(address playerAddress) public view returns(Level) {
        return players[playerAddress].playerLevel;
    }
}