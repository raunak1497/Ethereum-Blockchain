pragma solidity ^0.6.1;

contract owned{
    address owner;
    
    constructor() public{
        owner =  msg.sender;
    }
    
    modifier onlyOwner() {
        require(owner == msg.sender,"You are not the owner");
        _;
    }
    
}