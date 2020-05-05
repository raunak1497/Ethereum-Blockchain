pragma solidity ^0.6.1;

contract Functions{
    
    mapping(address => uint) public balanceReceived;
    
    //constructor
    address payable owner;
    
    constructor() public{
        owner =  msg.sender;
    }
    
    function destroySmartContract() public{
        require(owner== msg.sender ,"You are not the owner of Contract");
        selfdestruct(owner);
    }
    
    function getOwner() public view returns(address) {
        return owner;
    }
    
    function weiToEther(uint _amountInwei) public pure returns(uint) {
        return _amountInwei/1 ether;  
    } 
    
    function recieveMoney() public payable {
        
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    } 
    
    function withdrawMoney(address payable _to, uint _amount) public {
        
        require( _amount <= balanceReceived[msg.sender],"Insufficient balance"); 
        assert(balanceReceived[msg.sender] > balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);   
    }
    
    //The fallback function is called whenever the smart contract is called “as-is”, or if no other function
    receive () external payable{
        recieveMoney();
    }
}