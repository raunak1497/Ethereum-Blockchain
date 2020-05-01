pragma solidity ^0.6.1;

contract StartStopUpdateExample {
    
    address owner;
    
    bool public paused;
    
    constructor() public{
        owner = msg.sender;
    }
    
    function sendMoney() public payable {
    }
    
    function SetPaused(bool _paused) public {
        require( msg.sender == owner, "You are not the owner");
        paused = _paused;
    }
    
    function withdrawAllMoney(address payable _to) public {
        
        require(owner == msg.sender,"You are not the owner");
        require(paused, "The contract is paused");
        _to.transfer(address(this).balance);
    }
    
    function destroySmartContract(address payable _to) public {
         require(msg.sender == owner,"You are not the owner");
         selfdestruct(_to);
    } 
}