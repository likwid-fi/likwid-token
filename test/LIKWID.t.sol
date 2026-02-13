// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {LIKWID} from "../src/LIKWID.sol";
import "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";

contract LikwidTest is Test {
    LIKWID public token;

    function setUp() public {
        // token = new LIKWID();
    }

    function getHash(uint256 chainid, string memory biz, address sender, uint256 nonce, uint256 amount)
        public
        pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(biz, chainid, sender, nonce, amount));
    }

    function test_Increment() public {}

    function testFuzz_SetNumber(uint256 x) public {}

    function testHash() public view {
        address signer = 0xca709ea906207B44521f03eCf5B594d247DffAc5;
        bytes memory signature =
            hex"2579a3555ec51abb6a29cd959e1c70a8ea2e5981319e4ce0c0ae078cc14f5c7e2793f6b4ccfa6975cc3113d851a053b8d182a1e14c0cce96a3e12eea810244db1b";
        bytes32 hash = getHash(10143, "claim_option", 0xEA7744c4FA1101f9E6dF5688fc19e3EE94106439, 58, 93402334568016);
        console.logBytes32(hash);
        (address recovered, ECDSA.RecoverError err,) = ECDSA.tryRecover(hash, signature);
        console.logAddress(recovered);
        require(err == ECDSA.RecoverError.NoError);
        require(SignatureChecker.isValidSignatureNow(signer, hash, signature), "LIKWIDOption: verify error");
    }
}
