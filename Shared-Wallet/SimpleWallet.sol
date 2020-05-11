pragma solidity ^0.6.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract Allowance is Ownable{
    
    event AllowanceChanged(address indexed _forWho,address indexed _fromWhom,uint _oldAmount,uint _newAmount);
    
     mapping(address=>uint) public allowance;
    
    function addAllowance(address _who,uint _amount) public  onlyOwner{
        
        emit AllowanceChanged(_who,msg.sender,allowance[_who],_amount);
        allowance[_who] = _amount;
    }
    
    modifier ownerOrAllowed(uint _amount){
        require((owner() == msg.sender) || (allowance[msg.sender] >= _amount), "You are not allowed");
        _;
    }
    
    function reduceAllowance(address _who,uint _amount) internal {
        emit AllowanceChanged(_who,msg.sender,allowance[_who], allowance[_who] - _amount);
        allowance[_who] -= _amount;
    }
    
}

contract Simplewallet is Allowance{
    
   event MoneySent(address indexed benefeciary,uint amount);
   event MoneyRecieved(address indexed benefeciary,uint amount);
   
    function withdrawMoney(address payable  _to,uint _amount) public ownerOrAllowed(_amount) {
        require(_amount<= address(this).balance , "Insufficient fund");
        if( owner() != msg.sender){
            reduceAllowance(msg.sender,_amount);   
        }
        emit MoneySent(_to,_amount);
        _to.transfer(_amount);
    } 
    
    receive () external payable {
        emit MoneyRecieved(msg.sender,msg.value);
    } 
}