// SPDX-License-Identifier: MIT


pragma solidity 0.8.0;

contract Force {

    constructor() payable {

    }

   function kill(address payable _address) public {
       selfdestruct(_address);
   }
}
