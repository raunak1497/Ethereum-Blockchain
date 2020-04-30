pragma solidity ^0.6.1;


contract SendMoney {
    
    uint public balanceReceived;
    
    function RecieveMoney() public payable {
        balanceReceived += msg.value;
    
    }
    
    function getBalance() public view returns(uint){
        return address(this).balance;
    } 
    
    function withdrawMoney() public {
        address payable to = msg.sender;
        
        to.transfer(this.getBalance());
    }
    
    function withdrawMoneyTo(address payable _to) public{
        _to.transfer(this.getBalance());
    }
}