// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {LIKWID} from "../src/LIKWID.sol";

contract LIKWIDScript is Script {
    LIKWID public token;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        vm.stopBroadcast();
    }
}
