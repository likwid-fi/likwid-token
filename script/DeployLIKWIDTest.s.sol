// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {BaseTestScript} from "./BaseTestScript.sol";
import {LIKWID} from "../src/LIKWID.sol";
import {LIKWIDOption} from "../src/LIKWIDOption.sol";

contract LIKWIDScript is BaseTestScript, Script {
    LIKWID public token;
    LIKWIDOption public option;
    address treasury = 0xEA7744c4FA1101f9E6dF5688fc19e3EE94106439;
    address signer = 0xca709ea906207B44521f03eCf5B594d247DffAc5;

    function _getPaymentToken(uint256 chainId) internal pure returns (address _paymentToken) {
        if (chainId == SEPOLIA) {
            _paymentToken = 0xaA8E23Fb1079EA71e0a56F48a2aA51851D8433D0; //USDT
        } else if (chainId == BSC_TESTNET) {
            _paymentToken = 0x337610d27c682E347C9cD60BD4b3b107C9d34dDd; //USDT
        } else if (chainId == MONAD_TESTNET) {
            _paymentToken = 0x88b8E2161DEDC77EF4ab7585569D2415a1C1055D; //USDT
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
            revert EndpointNotExist();
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
