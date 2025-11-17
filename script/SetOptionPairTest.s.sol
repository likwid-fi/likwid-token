// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {LIKWID} from "../src/LIKWID.sol";
import {BaseTestScript} from "./BaseTestScript.sol";
import {ILayerZeroEndpointV2} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/ILayerZeroEndpointV2.sol";
import {SetConfigParam} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/IMessageLibManager.sol";
import {UlnConfig} from "@layerzerolabs/lz-evm-messagelib-v2/contracts/uln/UlnBase.sol";
import {ExecutorConfig} from "@layerzerolabs/lz-evm-messagelib-v2/contracts/SendLibBase.sol";
import {EnforcedOptionParam} from "@layerzerolabs/oapp-evm/contracts/oapp/libs/OAppOptionsType3.sol";
import {OptionsBuilder} from "@layerzerolabs/oapp-evm/contracts/oapp/libs/OptionsBuilder.sol";

contract SetPairScript is BaseTestScript, Script {
    using OptionsBuilder for bytes;

    LIKWID public token;

    uint32 constant EXECUTOR_CONFIG_TYPE = 1;
    uint32 constant ULN_CONFIG_TYPE = 2;
    uint32 constant RECEIVE_CONFIG_TYPE = 2;

    function setUp() public {}

    function run(uint256 chainId) public {
        uint256[] memory chains = new uint256[](3);
        chains[0] = MONAD_TESTNET;
        chains[1] = BSC_TESTNET;
        chains[2] = SEPOLIA;
        vm.startBroadcast();
        address aEndPoint = _getEndpoint(chainId);
        if (aEndPoint == address(0)) {
            revert EndpointNotExist();
        }
        uint32 srcEid = _getEid(chainId);
        if (srcEid == 0) {
            revert EidNotExist();
        }
        address sendLib = _getSendLib(chainId);
        if (sendLib == address(0)) {
            revert SendLibNotExist();
        }
        address receiveLib = _getReceiveLib(chainId);
        if (receiveLib == address(0)) {
            revert ReceiveLibNotExist();
        }
        address likwid = _getLikwidOption(chainId);
        if (likwid == address(0)) {
            revert TokenNotExist();
        }

        console.log("LIKWIDOption endpoint set for source chain ID:", chainId, "at address:", likwid);
        for (uint256 i = 0; i < chains.length; i++) {
            uint256 dstChainId = chains[i];
            if (dstChainId == chainId) {
                continue;
            }
            uint32 dstEid = uint32(_getEid(dstChainId));
            if (dstEid == 0) {
                revert EidNotExist();
            }
            LIKWID(likwid).setPeer(dstEid, bytes32(uint256(uint160(_getLikwidOption(dstChainId))))); // Set LIKWID peer for the destination chain
            console.log("Setting LIKWIDOption options for destination chain ID:", dstChainId, "at EID:", dstEid);
        }
        vm.stopBroadcast();
    }
}
