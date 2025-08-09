// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {OFT} from "@layerzerolabs/oft-evm/contracts/OFT.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";

contract LIKWIDOption is OFT, ERC20Permit {
    using SafeERC20 for IERC20;

    uint256 public immutable MAX_SUPPLY = 300_000_000 ether; // default: 300 million total tokens

    event OptionClaimed(address indexed user, uint256 amount);
    event OptionRedeemed(address indexed user, uint256 amount);

    IERC20 public immutable LIKWID;

    mapping(bytes signature => bool claimed) private claimedOptions;
    address public paymentToken; // payment token address
    uint256 public strikePrice = 0.03 ether; // 0.03 paymentToken per option;
    address public signer;
    address public treasury;

    constructor(
        uint256 mainChainId,
        address _lzEndpoint,
        address _delegate,
        address _treasury,
        address _signer,
        address _paymentToken,
        IERC20 _likwid
    )
        OFT("Likwid Option Token", "oLIKWID", _lzEndpoint, _delegate)
        Ownable(_delegate)
        ERC20Permit("Likwid Option Token")
    {
        treasury = _treasury;
        signer = _signer;
        paymentToken = _paymentToken;
        LIKWID = _likwid;
        // Ethereum mainnet chain ID is 1
        if (block.chainid == mainChainId) {
            _mint(_treasury, MAX_SUPPLY);
        }
    }

    function setTreasury(address _treasury) external onlyOwner {
        treasury = _treasury;
    }

    function setSigner(address _signer) external onlyOwner {
        signer = _signer;
    }

    function setPaymentToken(address _paymentToken) external onlyOwner {
        require(_paymentToken != address(0), "LIKWIDOption: payment token cannot be zero address");
        paymentToken = _paymentToken;
    }

    function setStrikePrice(uint256 _strikePrice) external onlyOwner {
        strikePrice = _strikePrice;
    }

    function getHash(string memory biz, address sender, uint256 nonce, uint256 amount) public view returns (bytes32) {
        return keccak256(abi.encodePacked(biz, block.chainid, sender, nonce, amount));
    }

    function claim(uint256 nonce, uint256 amount, bytes calldata signature) external {
        require(amount > 0, "LIKWIDOption: amount must be greater than zero");
        require(!claimedOptions[signature], "LIKWIDOption: option already claimed");
        bytes32 hash = getHash("claim_option", _msgSender(), nonce, amount);
        require(SignatureChecker.isValidSignatureNow(signer, hash, signature), "LIKWIDOption: verify error");

        claimedOptions[signature] = true;
        _transfer(address(this), _msgSender(), amount);

        emit OptionClaimed(_msgSender(), amount);
    }

    function redeem(uint256 amount) external {
        require(amount > 0, "LIKWIDOption: amount must be greater than zero");
        require(balanceOf(_msgSender()) >= amount, "LIKWIDOption: insufficient balance");
        require(LIKWID.balanceOf(address(this)) >= amount, "LIKWIDOption: LIKWID insufficient balance");

        uint256 paymentAmount = amount * strikePrice / 1 ether;
        IERC20(paymentToken).safeTransferFrom(_msgSender(), treasury, paymentAmount);
        _burn(_msgSender(), amount);
        LIKWID.safeTransfer(_msgSender(), amount);

        emit OptionRedeemed(_msgSender(), amount);
    }

    function withdraw(address token) external onlyOwner {
        if (token == address(0)) {
            uint256 balance = address(this).balance;
            require(balance > 0, "LIKWIDOption: no native balance to withdraw");
            (bool success,) = treasury.call{value: balance}("");
            require(success, "LIKWIDOption: native transfer failed");
        } else {
            uint256 balance = IERC20(token).balanceOf(address(this));
            require(balance > 0, "LIKWIDOption: no token balance to withdraw");
            IERC20(token).safeTransfer(treasury, balance);
        }
    }
}
