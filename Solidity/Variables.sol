pragma solidity *0.6.6;

contract MyContract{
    uint256 public myUint;
    
    function setMyUint( uint _myUint) public{
        myUint = _myUint;
    }
    
    bool public myBool;
    
    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }
    
    uint8 public myUint8;
    
    function incrementUint() public {
        myUint8++;
    }
    
    function decrementUint() public {
        myUint8--;
    }
    
    address public myAddress;
    
    function setAddress(address _myAddress) public{
        myAddress = _myAddress;
    }
    
    // view function are used to view and it returns
    function getBalanceAddress() public view returns(uint){
        //every address has a balance associated to it
        return myAddress.balance;
    }
    
    //strings are byte array in solidity
     
     string public myString = 'Hello world';
      
      //we need to specify where is the string stored so we specify memory
      function setString(string memory _myString) public{
          myString = _myString;
      }
      
      
     
}