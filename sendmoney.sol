pragma solidity ^0.6.1;


contract SendMoney {
    
    uint public balanceReceived;
    
    function RecieveMoney() public payable {
        balanceReceived += msg.value;
    
    }
    
    function getBalance() public view returns(uint){
        return address(this).balance;
    } 
}