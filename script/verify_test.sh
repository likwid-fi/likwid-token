#!/bin/bash
source ../.env
echo "Verify LIKWID on Sepolia"
forge verify-contract \
    --chain-id 11155111 \
    --optimizer-runs 1000000 \
    --evm-version cancun \
    --watch \
    --constructor-args $(cast abi-encode "constructor(uint256,address,address,address)" 11155111 "0x6EDCE65403992e310A62460808c4b910D972f10f" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1" "0xEA7744c4FA1101f9E6dF5688fc19e3EE94106439") \
    --etherscan-api-key $ETHER_API_KEY \
    --compiler-version v0.8.26+commit.8a97fa7a \
    0x9e32a617b6C4cF17ED33393A85840fB245c1aa13 \
    src/LIKWID.sol:LIKWID

echo "Verify LIKWID Option on Sepolia"
forge verify-contract \
    --chain-id 11155111 \
    --optimizer-runs 1000000 \
    --evm-version cancun \
    --watch \
    --constructor-args $(cast abi-encode "constructor(uint256,address,address,address,address,address,address)" 11155111 "0x6EDCE65403992e310A62460808c4b910D972f10f" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1" "0xEA7744c4FA1101f9E6dF5688fc19e3EE94106439" "0xca709ea906207B44521f03eCf5B594d247DffAc5" "0xaA8E23Fb1079EA71e0a56F48a2aA51851D8433D0" "0x9e32a617b6C4cF17ED33393A85840fB245c1aa13") \
    --etherscan-api-key $ETHER_API_KEY \
    --compiler-version v0.8.26+commit.8a97fa7a \
    0xC9235C89d6c35ef103C2FA1df3c61a92d628062b \
    src/LIKWIDOption.sol:LIKWIDOption

echo "Verify LIKWID on BSC Testnet"
forge verify-contract \
    --chain-id 97 \
    --optimizer-runs 1000000 \
    --evm-version cancun \
    --watch \
    --constructor-args $(cast abi-encode "constructor(uint256,address,address,address)" 97 "0x6EDCE65403992e310A62460808c4b910D972f10f" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1" "0xEA7744c4FA1101f9E6dF5688fc19e3EE94106439") \
    --etherscan-api-key $ETHER_API_KEY \
    --compiler-version v0.8.26+commit.8a97fa7a \
    0x9f4414c038D99782949A070995092e6b3DD1E27E \
    src/LIKWID.sol:LIKWID

echo "Verify LIKWID Option on BSC Testnet"
forge verify-contract \
    --chain-id 97 \
    --optimizer-runs 1000000 \
    --evm-version cancun \
    --watch \
    --constructor-args $(cast abi-encode "constructor(uint256,address,address,address,address,address,address)" 97 "0x6EDCE65403992e310A62460808c4b910D972f10f" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1" "0xEA7744c4FA1101f9E6dF5688fc19e3EE94106439" "0xca709ea906207B44521f03eCf5B594d247DffAc5" "0x337610d27c682E347C9cD60BD4b3b107C9d34dDd" "0x9f4414c038D99782949A070995092e6b3DD1E27E") \
    --etherscan-api-key $ETHER_API_KEY \
    --compiler-version v0.8.26+commit.8a97fa7a \
    0xf1De577bcAda3FEeBEB2890D719A204F4698B9c1 \
    src/LIKWIDOption.sol:LIKWIDOption

echo "Verify LIKWID on Monad Testnet"
forge verify-contract \
    --chain-id 10143 \
    --optimizer-runs 1000000 \
    --evm-version cancun \
    --watch \
    --constructor-args $(cast abi-encode "constructor(uint256,address,address,address)" 10143 "0x6C7Ab2202C98C4227C5c46f1417D81144DA716Ff" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1" "0xEA7744c4FA1101f9E6dF5688fc19e3EE94106439") \
    --etherscan-api-key $ETHER_API_KEY \
    --compiler-version v0.8.26+commit.8a97fa7a \
    0xe187a2102470EF4343E8597be97BB5E9d82C3CaD \
    src/LIKWID.sol:LIKWID

forge verify-contract \
  --rpc-url https://testnet-rpc.monad.xyz \
  --verifier sourcify \
  --verifier-url 'https://sourcify-api-monad.blockvision.org' \
  --constructor-args $(cast abi-encode "constructor(uint256,address,address,address)" 10143 "0x6C7Ab2202C98C4227C5c46f1417D81144DA716Ff" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1" "0xEA7744c4FA1101f9E6dF5688fc19e3EE94106439") \
  0xe187a2102470EF4343E8597be97BB5E9d82C3CaD \
  src/LIKWID.sol:LIKWID

echo "Verify LIKWID Option on Monad Testnet"
forge verify-contract \
    --chain-id 10143 \
    --optimizer-runs 1000000 \
    --evm-version cancun \
    --watch \
    --constructor-args $(cast abi-encode "constructor(uint256,address,address,address,address,address,address)" 10143 "0x6C7Ab2202C98C4227C5c46f1417D81144DA716Ff" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1" "0xEA7744c4FA1101f9E6dF5688fc19e3EE94106439" "0xca709ea906207B44521f03eCf5B594d247DffAc5" "0x88b8E2161DEDC77EF4ab7585569D2415a1C1055D" "0xe187a2102470EF4343E8597be97BB5E9d82C3CaD") \
    --etherscan-api-key $ETHER_API_KEY \
    --compiler-version v0.8.26+commit.8a97fa7a \
    0xCc8E34D68676406d253130038De8c0CF5158D6a9 \
    src/LIKWIDOption.sol:LIKWIDOption

forge verify-contract \
  --rpc-url https://testnet-rpc.monad.xyz \
  --verifier sourcify \
  --verifier-url 'https://sourcify-api-monad.blockvision.org' \
  --constructor-args $(cast abi-encode "constructor(uint256,address,address,address,address,address,address)" 10143 "0x6C7Ab2202C98C4227C5c46f1417D81144DA716Ff" "0x35D3F3497eC612b3Dd982819F95cA98e6a404Ce1" "0xEA7744c4FA1101f9E6dF5688fc19e3EE94106439" "0xca709ea906207B44521f03eCf5B594d247DffAc5" "0x88b8E2161DEDC77EF4ab7585569D2415a1C1055D" "0xe187a2102470EF4343E8597be97BB5E9d82C3CaD") \
  0xCc8E34D68676406d253130038De8c0CF5158D6a9 \
  src/LIKWIDOption.sol:LIKWIDOption