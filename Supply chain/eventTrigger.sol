// SPDX-License-Identifier: MIT
pragma solidity ^0.7.4;

contract ItemManager{
    
    enum SupplyChainState{Created,Paid,Delivered}
    
    struct S_item{
        string _identifier;
        uint _itemprice;
        ItemManager.SupplyChainState _state;
    }
    
    mapping(uint => S_item) items;
    uint itemIndex;
    
    event SupplyChainStep(uint itemIndex,uint _step);
    
    
    function createItem(string memory _identifier,uint _itemprice) public {
        items[itemIndex]._identifier = _identifier;
        items[itemIndex]._itemprice = _itemprice;
        items[itemIndex]._state = SupplyChainState.Created;
        emit SupplyChainStep(itemIndex,uint(items[itemIndex]._state));
        itemIndex++;
    }
    
    function triggerPayment(uint _itemIndex) public payable{
        require(items[_itemIndex]._itemprice == msg.value, "Only full payments accepted");
        require(items[_itemIndex]._state == SupplyChainState.Created, "Item is further in the chain");
        items[_itemIndex]._state = SupplyChainState.Paid;
        emit SupplyChainStep(itemIndex,uint(items[itemIndex]._state));
    }
    
    function triggerDelivery(uint _itemIndex) public{
        require(items[_itemIndex]._state == SupplyChainState.Paid, "Item is further in the chain");
        items[_itemIndex]._state = SupplyChainState.Delivered;
        emit SupplyChainStep(itemIndex,uint(items[itemIndex]._state));
    }
}
