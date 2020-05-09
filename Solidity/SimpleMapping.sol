pragma solidity ^0.6.1;

contract SimpleMapping{
    
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;
    
    function setValue(uint index) public{
        myMapping[index] = true;
    }
    
    function setMyAddress() public{
        myAddressMapping[msg.sender] = true;
    }
}