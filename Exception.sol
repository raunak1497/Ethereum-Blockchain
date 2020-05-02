pragma solidity ^0.6.1;

contract Exception {
    
    mapping(address => uint64) public balanceReceived;
    
    function recieveMoney() public payable {
        
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += uint64(msg.value);
    } 
    
    function withdrawMoney(address payable _to, uint64 _amount) public {
        
        require( _amount <= balanceReceived[msg.sender],"Insufficient balance"); 
        assert(balanceReceived[msg.sender] > balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);   
    }
}