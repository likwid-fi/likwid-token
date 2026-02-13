// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

contract BaseScript {
    error TokenNotExist();
    error EndpointNotExist();
    error EidNotExist();
    error SendLibNotExist();
    error ReceiveLibNotExist();
    error ExecutorNotExist();

    uint256 constant ETHEREUM = 1; // Ethereum mainnet

    uint256[] SUPPORTED_CHAINS = [ETHEREUM];

    uint256 constant MAIN_CHAINID = ETHEREUM; // Main Chain = Ethereum mainnet

    function _getEndpoint(uint256 chainId) internal pure returns (address _endpoint) {
        if (chainId == MAIN_CHAINID) {
            _endpoint = 0x1a44076050125825900e736c501f859c50fE728c;
        }
    }

    function _getEid(uint256 chainId) internal pure returns (uint32 _eid) {
        if (chainId == MAIN_CHAINID) {
            _eid = 30101;
        }
    }

    function _getSendLib(uint256 chainId) internal pure returns (address _sendLib) {
        if (chainId == MAIN_CHAINID) {
            _sendLib = 0xbB2Ea70C9E858123480642Cf96acbcCE1372dCe1;
        }
    }

    function _getReceiveLib(uint256 chainId) internal pure returns (address _receiveLib) {
        if (chainId == MAIN_CHAINID) {
            _receiveLib = 0xc02Ab410f0734EFa3F14628780e6e695156024C2;
        }
    }

    function _getDVNs(uint256 chainId) internal pure returns (address[] memory _dvns) {
        if (chainId == MAIN_CHAINID) {
            _dvns = new address[](2);
            _dvns[0] = 0xa59BA433ac34D2927232918Ef5B2eaAfcF130BA5; // Nethermind
            _dvns[1] = 0x589dEDbD617e0CBcB916A9223F4d1300c294236b; // LayerZero Labs
        }
    }

    function _getExecutor(uint256 chainId) internal pure returns (address _executor) {
        if (chainId == MAIN_CHAINID) {
            _executor = 0x173272739Bd7Aa6e4e214714048a9fE699453059;
        }
    }

    function checkBlockChainId(uint256 chainId) internal view {
        if (block.chainid > 0 && block.chainid != chainId) {
            revert("Invalid chain ID");
        }
    }

    // On mainnet, the LIKWID contract is deployed with the same address.
    function _getLikwid(uint256 chainId) internal pure returns (address _likwid) {
        if (chainId == MAIN_CHAINID) {
            //_likwid = 0x9e32a617b6C4cF17ED33393A85840fB245c1aa13;
        }
    }

    function _getLikwidOption(uint256 chainId) internal pure returns (address _likwidOption) {
        if (chainId == MAIN_CHAINID) {
            //_likwidOption = 0xC9235C89d6c35ef103C2FA1df3c61a92d628062b;
        }
    }
}
