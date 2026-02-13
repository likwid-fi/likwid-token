// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {BaseScript} from "./BaseScript.sol";
import {LIKWID} from "../../src/LIKWID.sol";
import {LIKWIDOption} from "../../src/LIKWIDOption.sol";

contract LIKWIDScript is BaseScript, Script {
    LIKWID public token;
    LIKWIDOption public option;
    address treasury = 0x1c01Da3d1FE1990C617fE47FF662265930c359F9;
    address signer = 0xca709ea906207B44521f03eCf5B594d247DffAc5;

    function _getPaymentToken(uint256 chainId) internal pure returns (address _paymentToken) {
        if (chainId == ETHEREUM) {
            _paymentToken = 0xdAC17F958D2ee523a2206206994597C13D831ec7; //USDT
        } else {
            _paymentToken = address(0); // Not deployed on other chains
        }
    }

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
            revert EidNotExist();
        }
        token = new LIKWID(
            MAIN_CHAINID,
            endpoint,
            msg.sender, // _delegate & owner
            treasury // treasury
        );
        console.log("Chain ID:", chainId);
        console.log("LIKWID deployed at:", address(token));
        address paymentToken = _getPaymentToken(chainId);
        if (paymentToken == address(0)) {
            console.log("Payment token not set for chain ID:", chainId);
            vm.stopBroadcast();
            return;
        }
        option = new LIKWIDOption(
            MAIN_CHAINID,
            endpoint,
            msg.sender, // _delegate & owner
            treasury, // treasury
            signer, // signer
            paymentToken,
            token
        );
        console.log("LIKWIDOption deployed at:", address(option));
        vm.stopBroadcast();
    }
}
