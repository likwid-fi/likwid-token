#!/bin/bash
source ../.env
echo "SetLIKWIDTest LIKWID on Sepolia"
forge script script/SetLIKWIDTest.s.sol --broadcast  --rpc-url https://sepolia.drpc.org --private-key $PRIVATE_KEY --sig "run(uint256)" 11155111 
echo "SetLIKWIDTest LIKWID on BSC Testnet"
forge script script/SetLIKWIDTest.s.sol --broadcast  --rpc-url https://bsc-testnet.public.blastapi.io --private-key $PRIVATE_KEY --sig "run(uint256)" 97 
echo "SetLIKWIDTest LIKWID on Monad Testnet"
forge script script/SetLIKWIDTest.s.sol --broadcast  --rpc-url https://testnet-rpc.monad.xyz --private-key $PRIVATE_KEY --sig "run(uint256)" 10143 