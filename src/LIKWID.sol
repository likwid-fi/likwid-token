// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {OFT} from "@layerzerolabs/oft-evm/contracts/OFT.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract LIKWID is OFT, ERC20Permit, AccessControl {
    uint256 public immutable MAX_SUPPLY = 1_000_000_000 * 10 ** 18; // 1 billion total tokens

    bytes32 public constant BLACKLISTER_ROLE = keccak256("BLACKLISTER_ROLE");

    mapping(address user => bool isBlacklisted) private blacklistedUsers;

    constructor(string memory _name, string memory _symbol, address _lzEndpoint, address _delegate)
        OFT(_name, _symbol, _lzEndpoint, _delegate)
        Ownable(_delegate)
        ERC20Permit(_name)
    {
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _mint(_msgSender(), MAX_SUPPLY);
    }

    function bulkBlacklistUpdate(address[] calldata accounts, bool[] calldata statuses)
        external
        onlyRole(BLACKLISTER_ROLE)
    {
        require(accounts.length == statuses.length, "LIKWID: malformed bulkBlacklist call");
        for (uint256 i; i < accounts.length; i++) {
            emit BlacklistUpdated(accounts[i], statuses[i]);
            blacklistedUsers[accounts[i]] = statuses[i];
        }
    }

    function blacklist(address account) external onlyRole(BLACKLISTER_ROLE) {
        emit BlacklistUpdated(account, true);
        blacklistedUsers[account] = true;
    }

    function unblacklist(address account) external onlyRole(BLACKLISTER_ROLE) {
        emit BlacklistUpdated(account, false);
        blacklistedUsers[account] = false;
    }

    function isBlackListed(address account) external view returns (bool) {
        return blacklistedUsers[account];
    }

    function _update(address from, address to, uint256 value) internal virtual override {
        require(!blacklistedUsers[from], "LIKWID: sender is blacklisted");
        require(!blacklistedUsers[to], "LIKWID: recipient is blacklisted");
        super._update(from, to, value);
    }
}
