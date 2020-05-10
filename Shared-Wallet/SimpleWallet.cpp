pragma solidity ^0.6.7;

contract Simplewallet{
    
    function withdrawl(address payable  _to,uint _amount) public {
        _to.transfer(_amount);
    } 
    
    receive () external payable {
        
    } 
}