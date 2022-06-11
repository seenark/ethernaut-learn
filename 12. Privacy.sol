// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;



contract PrivacyHack {

    function castBytes32ToBytes16(bytes32 _data) pure public returns(bytes16) {
        return bytes16(_data);
    }
}
