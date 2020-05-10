pragma solidity ^0.6.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Simplewallet is Ownable{
    
    function withdrawMoney(address payable  _to,uint _amount) public onlyOwner {
        _to.transfer(_amount);
    } 
    
    receive () external payable {
        
    } 
}