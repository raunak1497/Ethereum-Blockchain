pragma solidity 0.6.7;

contract Ownable{
    
    address payable _owner;
    
    constructor() public {
        _owner=msg.sender;
    }
    
    function isOwner() public view returns(bool){
        return (_owner==msg.sender);
    }
    
    modifier onlyOwner() {
        require(isOwner(),"You are not the owner");
        _;
    }
    
    
}


contract Item{
    uint public priceInWei;
    uint public index;
    uint public pricePaid;
    
    ItemManager parentContract;
    
    constructor(ItemManager _parentContract,uint _priceInWei,uint _index) public{
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }
    
    receive() external payable {
        require(pricePaid==0,"Item is paid already");
        require(priceInWei==msg.value,"Only full payment Allowed");
        pricePaid += msg.value;
        (bool success,) = address(parentContract).call{value: 1000000}(abi.encodeWithSignature("triggerPayment(uint)",index));
        require(success,"Transaction wasn't successful cancelling it");
        
    }
    
    fallback() external{
        
    }
}


contract ItemManager is Ownable{
    
    enum supplyChainState{created , paid , delivered}
    
    struct $_items{
        Item _item;
        string _identifier;
        uint _itemPrice;
        ItemManager.supplyChainState _state;
    }
    
    mapping(uint => $_items) public items;
    
    uint itemIndex;
    
    event SupplyChainStep(uint _itemIndex,uint _step,address itemAddress);
    
    function createItem(string memory _identifier,uint _itemPrice) public onlyOwner{
        
        Item item = new Item(this,_itemPrice,itemIndex);
        items[itemIndex]._item = item;
        items[itemIndex]._identifier = _identifier;
        items[itemIndex]._itemPrice = _itemPrice;
        items[itemIndex]._state = supplyChainState.created;
        
        emit SupplyChainStep(itemIndex,uint(items[itemIndex]._state),address(item));
        itemIndex++;
    }
    
    function triggerPayment(uint _itemIndex) public payable onlyOwner{
        require(items[_itemIndex]._itemPrice <= msg.value, "Only full payment accepted");
        require(items[_itemIndex]._state == supplyChainState.created, "Item is further in the chain");
        items[_itemIndex]._state = supplyChainState.paid;
        
        emit SupplyChainStep(_itemIndex,uint(items[_itemIndex]._state),address(items[_itemIndex]._item));
    }
    
    function triggerDelivery(uint _itemIndex) public onlyOwner{
        require(items[_itemIndex]._state == supplyChainState.paid, "Item is further in the chain");
        items[_itemIndex]._state = supplyChainState.delivered;
        
        emit SupplyChainStep(_itemIndex,uint(items[_itemIndex]._state),address(items[_itemIndex]._item));
    }
}

