// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {LIKWIDBase} from "./LIKWIDBase.sol";

contract LIKWID is LIKWIDBase {
    constructor(uint256 _mainChainId, address _lzEndpoint, address _delegate, address _treasury, uint256 _totalSupply)
        LIKWIDBase(_mainChainId, "Likwid Token", "LIKWID", 1_000_000_000 ether, _lzEndpoint, _delegate, _treasury)
    {}
}
