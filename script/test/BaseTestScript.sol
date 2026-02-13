// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

contract BaseTestScript {
    error TokenNotExist();
    error EndpointNotExist();
    error EidNotExist();
    error SendLibNotExist();
    error ReceiveLibNotExist();
    error ExecutorNotExist();

    uint256 constant MONAD_TESTNET = 10143; // Monad testnet
    uint256 constant BSC_TESTNET = 97; // BSC testnet
    uint256 constant SEPOLIA = 11155111; // Sepolia

    uint256[] SUPPORTED_CHAINS = [MONAD_TESTNET, BSC_TESTNET, SEPOLIA];

    uint256 constant MAIN_CHAINID = SEPOLIA; // Main Chain = Monad testnet

    function _getEndpoint(uint256 chainId) internal pure returns (address _endpoint) {
        if (chainId == BSC_TESTNET) {
            // BSC testnet
            _endpoint = 0x6EDCE65403992e310A62460808c4b910D972f10f;
        } else if (chainId == SEPOLIA) {
            // Sepolia
            _endpoint = 0x6EDCE65403992e310A62460808c4b910D972f10f;
        } else if (chainId == MONAD_TESTNET) {
            // Monad testnet
            _endpoint = 0x6C7Ab2202C98C4227C5c46f1417D81144DA716Ff;
        }
    }

    function _getEid(uint256 chainId) internal pure returns (uint32 _eid) {
        if (chainId == SEPOLIA) {
            _eid = 40161;
        } else if (chainId == BSC_TESTNET) {
            _eid = 40102;
        } else if (chainId == MONAD_TESTNET) {
            _eid = 40204;
        }
    }

    function _getSendLib(uint256 chainId) internal pure returns (address _sendLib) {
        if (chainId == SEPOLIA) {
            _sendLib = 0xcc1ae8Cf5D3904Cef3360A9532B477529b177cCE;
        } else if (chainId == BSC_TESTNET) {
            _sendLib = 0x55f16c442907e86D764AFdc2a07C2de3BdAc8BB7;
        } else if (chainId == MONAD_TESTNET) {
            _sendLib = 0xd682ECF100f6F4284138AA925348633B0611Ae21;
        }
    }

    function _getReceiveLib(uint256 chainId) internal pure returns (address _receiveLib) {
        if (chainId == SEPOLIA) {
            _receiveLib = 0xdAf00F5eE2158dD58E0d3857851c432E34A3A851;
        } else if (chainId == BSC_TESTNET) {
            _receiveLib = 0x188d4bbCeD671A7aA2b5055937F79510A32e9683;
        } else if (chainId == MONAD_TESTNET) {
            _receiveLib = 0xcF1B0F4106B0324F96fEfcC31bA9498caa80701C;
        }
    }

    function _getDVNs(uint256 chainId) internal pure returns (address[] memory _dvns) {
        if (chainId == SEPOLIA) {
            _dvns = new address[](2);
            _dvns[0] = 0x68802e01D6321D5159208478f297d7007A7516Ed; // Nethermind
            _dvns[1] = 0x8eebf8b423B73bFCa51a1Db4B7354AA0bFCA9193; // LayerZero Labs
        } else if (chainId == BSC_TESTNET) {
            _dvns = new address[](2);
            _dvns[0] = 0x0eE552262f7B562eFcED6DD4A7e2878AB897d405; // LayerZero Labs
            _dvns[1] = 0x6334290B7b4a365F3c0E79c85B1b42F078db78E4; // Nethermind
        } else if (chainId == MONAD_TESTNET) {
            _dvns = new address[](2);
            _dvns[0] = 0x88B27057A9e00c5F05DDa29241027afF63f9e6e0; // LayerZero Labs
            _dvns[1] = 0xB365Da66084D135E9bfaef73EB8be06029271681; // Nethermind
        }
    }

    function _getExecutor(uint256 chainId) internal pure returns (address _executor) {
        if (chainId == SEPOLIA) {
            _executor = 0x718B92b5CB0a5552039B593faF724D182A881eDA;
        } else if (chainId == BSC_TESTNET) {
            _executor = 0x31894b190a8bAbd9A067Ce59fde0BfCFD2B18470;
        } else if (chainId == MONAD_TESTNET) {
            _executor = 0x9dB9Ca3305B48F196D18082e91cB64663b13d014;
        }
    }

    function checkBlockChainId(uint256 chainId) internal view {
        if (block.chainid > 0 && block.chainid != chainId) {
            revert("Invalid chain ID");
        }
    }

    // On mainnet, the LIKWID contract is deployed with the same address.
    function _getLikwid(uint256 chainId) internal pure returns (address _likwid) {
        if (chainId == SEPOLIA) {
            _likwid = 0x9e32a617b6C4cF17ED33393A85840fB245c1aa13;
        } else if (chainId == BSC_TESTNET) {
            _likwid = 0x9f4414c038D99782949A070995092e6b3DD1E27E;
        } else if (chainId == MONAD_TESTNET) {
            _likwid = 0xe187a2102470EF4343E8597be97BB5E9d82C3CaD;
        } else {
            _likwid = address(0); // Not deployed on other chains
        }
    }

    function _getLikwidOption(uint256 chainId) internal pure returns (address _likwidOption) {
        if (chainId == SEPOLIA) {
            _likwidOption = 0xC9235C89d6c35ef103C2FA1df3c61a92d628062b;
        } else if (chainId == BSC_TESTNET) {
            _likwidOption = 0xf1De577bcAda3FEeBEB2890D719A204F4698B9c1;
        } else if (chainId == MONAD_TESTNET) {
            _likwidOption = 0xCc8E34D68676406d253130038De8c0CF5158D6a9;
        } else {
            _likwidOption = address(0); // Not deployed on other chains
        }
    }
}
