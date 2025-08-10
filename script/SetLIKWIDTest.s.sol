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

contract SetLIKWIDScript is BaseTestScript, Script {
    using OptionsBuilder for bytes;

    LIKWID public token;

    uint32 constant EXECUTOR_CONFIG_TYPE = 1;
    uint32 constant ULN_CONFIG_TYPE = 2;
    uint32 constant RECEIVE_CONFIG_TYPE = 2;

    function setUp() public {}

    function run(uint256 chainId) public {
        checkBlockChainId(chainId);
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
        address likwid = _getLikwid(chainId);
        if (likwid == address(0)) {
            revert TokenNotExist();
        }
        uint256 gracePeriod = 0; // Set to 0 for immediate library switch
            // Set receive library for inbound messages
        (address lib,) = ILayerZeroEndpointV2(aEndPoint).getReceiveLibrary(
            likwid, // OApp address
            srcEid // Source chain EID
        );
        if (lib == address(0)) {
            ILayerZeroEndpointV2(aEndPoint).setReceiveLibrary(
                likwid, // OApp address
                srcEid, // Source chain EID
                receiveLib, // ReceiveUln302 address
                gracePeriod // Grace period for library switch
            );
        }

        address[] memory aDvns = _getDVNs(chainId);
        address[] memory optionalDVNs;
        address aExecutor = _getExecutor(chainId);
        if (aExecutor == address(0)) {
            revert ExecutorNotExist();
        }
        EnforcedOptionParam[] memory enforcedOptions = new EnforcedOptionParam[](SUPPORTED_CHAINS.length - 1);
        uint256 optionIndex = 0;
        uint16 SEND = 1; // Message type for sendString function
        console.log("LIKWID endpoint set for source chain ID:", chainId, "at address:", likwid);
        for (uint256 i = 0; i < SUPPORTED_CHAINS.length; i++) {
            uint256 dstChainId = SUPPORTED_CHAINS[i];
            if (dstChainId == chainId) {
                continue;
            }
            uint32 dstEid = uint32(_getEid(dstChainId));
            if (dstEid == 0) {
                revert EidNotExist();
            }
            bytes32 dstPeer = bytes32(uint256(uint160(_getLikwid(dstChainId))));
            if (LIKWID(likwid).isPeer(dstEid, dstPeer)) {
                console.log("LIKWID peer already set for destination chain ID:", dstChainId, "at EID:", dstEid);
                continue;
            }
            LIKWID(likwid).setPeer(dstEid, dstPeer); // Set LIKWID peer for the destination chain
            console.log("Setting LIKWID options for destination chain ID:", dstChainId, "at EID:", dstEid);
            // Build options using OptionsBuilder
            bytes memory options = OptionsBuilder.newOptions().addExecutorLzReceiveOption(100000, 0);
            enforcedOptions[optionIndex] = EnforcedOptionParam({eid: dstEid, msgType: SEND, options: options});
            optionIndex++;
            // Set send library for outbound messages
            ILayerZeroEndpointV2(aEndPoint).setSendLibrary(
                likwid, // OApp address
                dstEid, // Destination chain EID
                sendLib // SendUln302 address
            );

            UlnConfig memory sendUln = UlnConfig({
                confirmations: 15, // minimum block confirmations required on A before sending to B
                requiredDVNCount: 2, // number of DVNs required
                optionalDVNCount: type(uint8).max, // optional DVNs count, uint8
                optionalDVNThreshold: 0, // optional DVN threshold
                requiredDVNs: aDvns, // sorted list of required DVN addresses
                optionalDVNs: optionalDVNs // sorted list of optional DVNs
            });

            /// @notice ExecutorConfig sets message size limit + fee‑paying executor for A → B
            ExecutorConfig memory sendExec = ExecutorConfig({
                maxMessageSize: 10000, // max bytes per cross-chain message
                executor: aExecutor // address that pays destination execution fees on B
            });

            bytes memory sendEncodedUln = abi.encode(sendUln);
            bytes memory sendEncodedExec = abi.encode(sendExec);

            SetConfigParam[] memory sendParams = new SetConfigParam[](2);
            sendParams[0] = SetConfigParam(dstEid, EXECUTOR_CONFIG_TYPE, sendEncodedExec);
            sendParams[1] = SetConfigParam(dstEid, ULN_CONFIG_TYPE, sendEncodedUln);

            ILayerZeroEndpointV2(aEndPoint).setConfig(likwid, sendLib, sendParams); // Set config for messages sent from A to B

            UlnConfig memory uln = UlnConfig({
                confirmations: 15, // min block confirmations from source (B)
                requiredDVNCount: 2, // required DVNs for message acceptance
                optionalDVNCount: type(uint8).max, // optional DVNs count
                optionalDVNThreshold: 0, // optional DVN threshold
                requiredDVNs: aDvns, // sorted required DVNs
                optionalDVNs: optionalDVNs // no optional DVNs
            });

            bytes memory encodedUln = abi.encode(uln);

            SetConfigParam[] memory params = new SetConfigParam[](1);
            params[0] = SetConfigParam(dstEid, RECEIVE_CONFIG_TYPE, encodedUln);

            ILayerZeroEndpointV2(aEndPoint).setConfig(likwid, receiveLib, params); // Set config for messages received on A from B
        }
        LIKWID(likwid).setEnforcedOptions(enforcedOptions);
        vm.stopBroadcast();
    }
}
