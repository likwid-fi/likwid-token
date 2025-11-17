#!/bin/bash
source ../.env
echo "SetLIKWIDTest LIKWID on Sepolia"
forge script script/SetLIKWIDTest.s.sol --broadcast  --rpc-url https://sepolia.drpc.org --private-key $PRIVATE_KEY --sig "run(uint256)" 11155111 
echo "SetLIKWIDTest LIKWID on BSC Testnet"
forge script script/SetLIKWIDTest.s.sol --broadcast  --rpc-url https://bsc-testnet.infura.io/v3/e9fa18da7a064062a73d7d1aad864900 --private-key $PRIVATE_KEY --sig "run(uint256)" 97 
echo "SetLIKWIDTest LIKWID on Monad Testnet"
forge script script/SetLIKWIDTest.s.sol --broadcast  --rpc-url https://testnet-rpc.monad.xyz --gas-estimate-multiplier 200 --private-key $PRIVATE_KEY --sig "run(uint256)" 10143 

echo "SetLIKWIDTest LIKWID Option on Sepolia"
forge script script/SetLIKWIDOptionTest.s.sol --broadcast  --rpc-url https://sepolia.drpc.org --private-key $PRIVATE_KEY --sig "run(uint256)" 11155111 
echo "SetLIKWIDTest LIKWID Option on BSC Testnet"
forge script script/SetLIKWIDOptionTest.s.sol --broadcast  --rpc-url https://bsc-testnet.infura.io/v3/e9fa18da7a064062a73d7d1aad864900 --private-key $PRIVATE_KEY --sig "run(uint256)" 97 
echo "SetLIKWIDTest LIKWID Option on Monad Testnet"
forge script script/SetLIKWIDOptionTest.s.sol --broadcast  --rpc-url https://testnet-rpc.monad.xyz --gas-estimate-multiplier 200 --private-key $PRIVATE_KEY --sig "run(uint256)" 10143 