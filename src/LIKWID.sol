// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {OFT} from "@layerzerolabs/oft-evm/contracts/OFT.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract LIKWID is OFT, ERC20Permit {
    uint256 public immutable MAX_SUPPLY = 1_000_000_000 ether; // default: 1 billion total tokens

    constructor(uint256 MAIN_CHAINID, address _lzEndpoint, address _delegate, address _treasury)
        OFT("Likwid Token", "LIKWID", _lzEndpoint, _delegate)
        Ownable(_delegate)
        ERC20Permit("Likwid Token")
    {
        // Ethereum mainnet chain ID is 1
        if (block.chainid == MAIN_CHAINID) {
            _mint(_treasury, MAX_SUPPLY);
        }
    }
}
