// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {LIKWIDBase} from "./LIKWIDBase.sol";

contract LIKWID is LIKWIDBase {
    constructor(uint256 _mainChainId, address _lzEndpoint, address _delegate, address _treasury)
        LIKWIDBase(_mainChainId, "Likwid Token", "LIKWID", _lzEndpoint, _delegate, _treasury)
    {}
}
