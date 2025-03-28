// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {LIKWID} from "../src/LIKWID.sol";

contract LIKWIDScript is Script {
    error EndpointNotExist();

    LIKWID public token;

    uint256 constant mainChainId = 97;

    function setUp() public {}

    function _getEndpoint(uint256 chainId) internal pure returns (address _endpoint) {
        if (chainId == 97) {
            _endpoint = 0x6EDCE65403992e310A62460808c4b910D972f10f;
        } else if (chainId == 11155111) {
            _endpoint = 0x6EDCE65403992e310A62460808c4b910D972f10f;
        }
    }

    function _getEid(uint256 chainId) internal pure returns (uint32 _eid) {
        if (chainId == 11155111) {
            _eid = 40161;
        } else if (chainId == 97) {
            _eid = 40102;
        }
    }

    function run(uint256 chainId, uint256 pairChainId) public {
        vm.startBroadcast();
        address endpoint = _getEndpoint(chainId);
        if (endpoint == address(0)) {
            revert EndpointNotExist();
        }
        uint32 eid = _getEid(pairChainId);
        if (eid == 0) {
            revert EndpointNotExist();
        }
        vm.stopBroadcast();
    }
}
