#!/bin/bash
source ../.env
echo "Verify LIKWID on Sepolia"
forge verify-contract \
    --chain-id 11155111 \
    --optimizer-runs 1000000 \
    --evm-version cancun \
    --watch \
    --constructor-args $(cast abi-encode "constructor(uint256,address,address,address)" 11155111 "0x6EDCE65403992e310A62460808c4b910D972f10f" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1") \
    --etherscan-api-key $ETHER_API_KEY \
    --compiler-version v0.8.26+commit.8a97fa7a \
    0x37c96b7F52d0E165832Ba8f614f91E76e36F1bcc \
    src/LIKWID.sol:LIKWID
echo "Verify LIKWID on BSC Testnet"
forge verify-contract \
    --chain-id 97 \
    --optimizer-runs 1000000 \
    --evm-version cancun \
    --watch \
    --constructor-args $(cast abi-encode "constructor(uint256,address,address,address)" 97 "0x6EDCE65403992e310A62460808c4b910D972f10f" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1") \
    --etherscan-api-key $ETHER_API_KEY \
    --compiler-version v0.8.26+commit.8a97fa7a \
    0xDa4e2a0C4AAa142f0D5f5C56fc3651DcfD2c9657 \
    src/LIKWID.sol:LIKWID
echo "Verify LIKWID on Monad Testnet"
forge verify-contract \
    --chain-id 10143 \
    --optimizer-runs 1000000 \
    --evm-version cancun \
    --watch \
    --constructor-args $(cast abi-encode "constructor(uint256,address,address,address)" 10143 "0x6C7Ab2202C98C4227C5c46f1417D81144DA716Ff" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1") \
    --etherscan-api-key $ETHER_API_KEY \
    --compiler-version v0.8.26+commit.8a97fa7a \
    0x716CE8f47504bC7E6E4bd29856585a2e202a4De6 \
    src/LIKWID.sol:LIKWID