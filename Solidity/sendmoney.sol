pragma solidity *0.6.6;

contract sendMoney{
    
    //msg is globaly defined in solidity
    uint public balanceRecieved; 
    
    //payable tells compiler that this functio is gonna recieve money
    function recieveMoney() public payable{
        balanceRecieved+=msg.value;
    }
    
    //this is the instance of the smart contract
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    
    function withdrawMoney() public payable{
        address payable to = msg.sender;
        
        to.transfer(this.getBalance());
    }
    
    function withdrawMoneyTo(address payable _to) public{
        _to.transfer(this.getBalance());
    }
}