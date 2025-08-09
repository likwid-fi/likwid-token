// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {LIKWID} from "../src/LIKWID.sol";

contract LIKWIDScript is Script {
    error EndpointNotExist();

    LIKWID public token;

    uint256 constant monadTestnetChainId = 10143; // Monad testnet
    uint256 constant bscTestnetChainId = 97; // BSC testnet
    uint256 constant sepoliaChainId = 11155111; // Sepolia

    uint256 constant mainChainId = monadTestnetChainId; // Sepolia

    function setUp() public {}

    function _getEndpoint(uint256 chainId) internal pure returns (address _endpoint) {
        if (chainId == bscTestnetChainId) {
            // BSC testnet
            _endpoint = 0x6EDCE65403992e310A62460808c4b910D972f10f;
        } else if (chainId == sepoliaChainId) {
            // Sepolia
            _endpoint = 0x6EDCE65403992e310A62460808c4b910D972f10f;
        } else if (chainId == monadTestnetChainId) {
            // Monad testnet
            _endpoint = 0x6C7Ab2202C98C4227C5c46f1417D81144DA716Ff;
        }
    }

    function _getEid(uint256 chainId) internal pure returns (uint32 _eid) {
        if (chainId == sepoliaChainId) {
            _eid = 40161;
        } else if (chainId == bscTestnetChainId) {
            _eid = 40102;
        } else if (chainId == monadTestnetChainId) {
            _eid = 40204;
        }
    }

    function run(uint256 chainId) public {
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
            mainChainId,
            endpoint,
            msg.sender, // _delegate & owner
            msg.sender // treasury
        );
        console.log("LIKWID deployed at:", address(token));
        console.log("Chain ID:", chainId);
        vm.stopBroadcast();
    }
}
