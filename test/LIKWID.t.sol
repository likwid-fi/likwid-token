// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {LIKWID} from "../src/LIKWID.sol";

contract LikwidTest is Test {
    LIKWID public token;

    function setUp() public {
        // token = new LIKWID();
    }

    function test_Increment() public {}

    function testFuzz_SetNumber(uint256 x) public {}
}
