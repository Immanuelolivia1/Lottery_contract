//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract Lottery{
    address payable[] public players;
    address public verifier;
    address payable winner;

    constructor(){
        verifier == msg.sender;
    } 


    function participate() public payable {
        require(msg.value == 3 ether, "insuficient funds");
        players.push(payable(msg.sender));
    }

    // function afterBlockStamp() public payable
    
    function getBalance() public view returns(uint){
        require(verifier == msg.sender, "you're not a valid verifier");
        return address(this).balance;
    }

    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }

    function getWinner() public{
        require(verifier == msg.sender);
        require(players.length >= 3,"players not complete");
        uint r = random();

        uint index = r%players.length;
        winner = players[index];
        players = new address payable[](0);
        winner.transfer(getBalance());

    }
}