// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

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
        uint createdTime;
    }

    function addPlayer(string memory firstName, string memory lastName) public {
        //players.push(Player(firstName, lastName));
        players[msg.sender] = Player(msg.sender,Level.Novice,firstName, lastName, block.timestamp);
        playerCount += 1;
    }

    function getPlayerLevel(address playerAddress) public view returns(Level) {
        Player storage player = players[playerAddress];
        return player.playerLevel;
    }

    function changePlayerLevel(address playerAddress) public {
        Player storage player = players[playerAddress];
        if (block.timestamp >= player.createdTime+20) {
            player.playerLevel = Level.Intermediate;
        }
    }
}