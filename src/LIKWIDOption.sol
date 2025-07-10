// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {LIKWIDBase} from "./LIKWIDBase.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";

contract LIKWIDOption is LIKWIDBase {
    using SafeERC20 for IERC20;

    event OptionClaimed(address indexed user, uint256 amount);

    mapping(bytes signature => bool claimed) private claimedOptions;
    address public signer;
    address public immutable paymentToken;
    uint256 public paymentPrice = 0.2 ether; // 0.2 paymentToken per option;
    address public treasury;
    IERC20 public immutable likwid;

    constructor(
        uint256 _mainChainId,
        address _lzEndpoint,
        address _delegate,
        address _treasury,
        address _signer,
        address _paymentToken,
        IERC20 _likwid
    ) LIKWIDBase(_mainChainId, "Likwid Option Token", "oLIKWID", _lzEndpoint, _delegate, _treasury) {
        treasury = _treasury;
        signer = _signer;
        paymentToken = _paymentToken;
        likwid = _likwid;
    }

    function setTreasury(address _treasury) external onlyOwner {
        treasury = _treasury;
    }

    function setSigner(address _signer) external onlyOwner {
        signer = _signer;
    }

    function setPaymentPrice(uint256 _paymentPrice) external onlyOwner {
        paymentPrice = _paymentPrice;
    }

    function getHash(string memory biz, string memory symbol, uint256 amount, address sender)
        public
        pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(biz, symbol, amount, sender));
    }

    function claim(uint256 amount, bytes calldata signature) external {
        require(amount > 0, "LIKWIDOption: amount must be greater than zero");
        require(!claimedOptions[signature], "LIKWIDOption: option already claimed");
        bytes32 hash = getHash("claim", symbol(), amount, _msgSender());
        require(SignatureChecker.isValidSignatureNow(signer, hash, signature), "LIKWIDOption: verify error");
        claimedOptions[signature] = true;
        transfer(_msgSender(), amount);

        emit OptionClaimed(_msgSender(), amount);
    }

    function redeem(uint256 amount) external {
        require(amount > 0, "LIKWIDOption: amount must be greater than zero");
        require(balanceOf(_msgSender()) >= amount, "LIKWIDOption: insufficient balance");
        require(likwid.balanceOf(address(this)) >= amount, "LIKWIDOption: LIKWID insufficient balance");
        _burn(_msgSender(), amount);
        uint256 paymentAmount = amount * paymentPrice / 1 ether;
        IERC20(paymentToken).safeTransferFrom(_msgSender(), treasury, paymentAmount);
        likwid.safeTransfer(_msgSender(), amount);
    }
}
