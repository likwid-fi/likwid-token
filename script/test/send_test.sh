#!/bin/bash
source ../.env
echo "Send LIKWID from Monad Testnet to BSC Testnet"
forge script script/SendOFTTest.s.sol --broadcast --optimizer-runs 1000000 --rpc-url https://testnet-rpc.monad.xyz  --private-key $PRIVATE_KEY --sig "run(uint256,uint256,uint256)" 10143 97 10000000
echo "Send LIKWID from Monad Testnet to Sepolia"
forge script script/SendOFTTest.s.sol --broadcast --optimizer-runs 1000000 --rpc-url https://testnet-rpc.monad.xyz  --private-key $PRIVATE_KEY --sig "run(uint256,uint256,uint256)" 10143 11155111 1000
echo "Send LIKWID from BSC Testnet to Monad Testnet"
forge script script/SendOFTTest.s.sol --broadcast --optimizer-runs 1000000 --rpc-url https://bsc-testnet.public.blastapi.io --private-key $PRIVATE_KEY --sig "run(uint256,uint256,uint256)" 97 10143 97
echo "Send LIKWID from BSC Testnet to Sepolia"
forge script script/SendOFTTest.s.sol --broadcast --optimizer-runs 1000000 --rpc-url https://bsc-testnet.public.blastapi.io --private-key $PRIVATE_KEY --sig "run(uint256,uint256,uint256)" 97 11155111 97
echo "Send LIKWID from Sepolia to Monad Testnet"
forge script script/SendOFTTest.s.sol --broadcast --optimizer-runs 1000000 --rpc-url https://sepolia.drpc.org --private-key $PRIVATE_KEY --sig "run(uint256,uint256,uint256)" 11155111 10143 10000000
echo "Send LIKWID from Sepolia to BSC Testnet"
forge script script/SendOFTTest.s.sol --broadcast --optimizer-runs 1000000 --rpc-url https://sepolia.drpc.org --private-key $PRIVATE_KEY --sig "run(uint256,uint256,uint256)" 11155111 97 111
