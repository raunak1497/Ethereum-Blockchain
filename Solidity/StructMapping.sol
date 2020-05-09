pragma solidity ^0.6.1;

contract StructMapping{
    
    struct Payment{
        uint amount;
        uint timestamp;
    }
    
    struct Balance {
        uint totalBalance;
        uint numPayment;
        mapping (uint => Payment) payments;
        
        
    }
    mapping(address => Balance) public balanceReceived;
    
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    
    function sendMoney() public payable {
        
        balanceReceived[msg.sender].totalBalance += msg.value;
        
        Payment memory payment = Payment(msg.value,now);
        
        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayment] = payment;
        balanceReceived[msg.sender].numPayment++;
        
    }
    
    function withdrawMoney(address payable _to,uint _amount) public{
        
        require( balanceReceived[msg.sender].totalBalance > _amount, "Insufficient Balance");
        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
        // balanceReceived[_to] += _amount;
    }
    function withdrawAllMoney(address payable _to)  public {
        
        uint balanceToSend = balanceReceived[msg.sender].totalBalance;
        balanceReceived[msg.sender].totalBalance = 0;
        _to.transfer(balanceToSend);
    }
    
}