// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {BaseTestScript} from "./BaseTestScript.sol";
import {LIKWID} from "../src/LIKWID.sol";

contract LIKWIDScript is BaseTestScript, Script {
    LIKWID public token;

    function run(uint256 chainId) public {
        checkBlockChainId(chainId);
        address likwid = _getLikwid(chainId);
        if (likwid != address(0)) {
            console.log("LIKWID already deployed at:", likwid);
            return;
        }
        vm.startBroadcast();
        address endpoint = _getEndpoint(chainId);
        if (endpoint == address(0)) {
            revert EndpointNotExist();
        }
        uint32 eid = _getEid(chainId);
        if (eid == 0) {
            revert EndpointNotExist();
        }
        token = new LIKWID(
            MAIN_CHAINID,
            endpoint,
            msg.sender, // _delegate & owner
            msg.sender // treasury
        );
        console.log("LIKWID deployed at:", address(token));
        console.log("Chain ID:", chainId);
        vm.stopBroadcast();
    }
}
