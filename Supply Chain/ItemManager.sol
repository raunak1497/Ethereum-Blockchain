pragma solidity 0.6.8;

contract ItemManager{
    
    enum supplyChainState{created , paid , delivered}
    
    struct $_items{
        string _identifier;
        uint _itemPrice;
        ItemManager.supplyChainState _state;
    }
    
    mapping(uint => $_items) public items;
    
    uint itemIndex;
    
    event SupplyChainStep(uint _itemIndex,uint _step);
    
    function createItem(string memory _identifier,uint _itemPrice) public {
        items[itemIndex]._identifier = _identifier;
        items[itemIndex]._itemPrice = _itemPrice;
        items[itemIndex]._state = supplyChainState.created;
        
        emit SupplyChainStep(itemIndex,uint(items[itemIndex]._state));
        itemIndex++;
    }
    
    function triggerPayment(uint _itemIndex) public payable {
        require(items[_itemIndex]._itemPrice <= msg.value, "ONly full payment accepted");
        require(items[_itemIndex]._state == supplyChainState.created, "Item is further in the chain");
        items[_itemIndex]._state = supplyChainState.paid;
        
        emit SupplyChainStep(_itemIndex,uint(items[_itemIndex]._state));
    }
    
    function triggerDelivery(uint _itemIndex) public {
        require(items[_itemIndex]._state == supplyChainState.paid, "Item is further in the chain");
        items[_itemIndex]._state = supplyChainState.delivered;
        
        emit SupplyChainStep(_itemIndex,uint(items[_itemIndex]._state));
    }
}