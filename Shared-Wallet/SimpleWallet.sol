pragma solidity ^0.6.7;

contract Simplewallet{
    
    address public owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(owner == msg.sender,"You are not the owner");   
        _;
    }
    
    function withdrawMoney(address payable  _to,uint _amount) public onlyOwner {
        _to.transfer(_amount);
    } 
    
    receive () external payable {
        
    } 
}