pragma solidity ^0.6.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Simplewallet is Ownable{
    
    mapping(address=>uint) public allowance;
    
    function addAllowance(address _who,uint _amount) public  onlyOwner{
        allowance[_who] = _amount;
    }
    
    modifier ownerOrAllowed(uint _amount){
        require((owner() == msg.sender) || (allowance[msg.sender] >= _amount), "You are not allowed");
        _;
    }
    
    function reduceAllowance(address _who,uint _amount) internal {
        allowance[_who] -= _amount;
    }
    
    function withdrawMoney(address payable  _to,uint _amount) public ownerOrAllowed(_amount) {
        require(_amount<= address(this).balance , "Insufficient fund");
        if( owner() != msg.sender){
            reduceAllowance(msg.sender,_amount);   
        }
        _to.transfer(_amount);
    } 
    
    receive () external payable {
        
    } 
}