#!/bin/bash
source ../.env
echo "Deploying LIKWID on Sepolia"
forge script script/DeployLIKWIDTest.s.sol --broadcast --optimizer-runs 1000000 --rpc-url https://sepolia.drpc.org --private-key $PRIVATE_KEY --sig "run(uint256)" 11155111 
echo "Deploying LIKWID on BSC Testnet"
forge script script/DeployLIKWIDTest.s.sol --broadcast --optimizer-runs 1000000 --rpc-url https://bnb-testnet.api.onfinality.io/public --private-key $PRIVATE_KEY --sig "run(uint256)" 97 
echo "Deploying LIKWID on Monad Testnet"
forge script script/DeployLIKWIDTest.s.sol --broadcast --optimizer-runs 1000000 --rpc-url https://monad-testnet.drpc.org --private-key $PRIVATE_KEY --sig "run(uint256)" 10143 