## Setup

Prepare config

```json
{
  "solidity.packageDefaultDependenciesContractsDirectory": "src",
  "solidity.packageDefaultDependenciesDirectory": "lib",
  "editor.formatOnSave": true,
  "[solidity]": {
    "editor.defaultFormatter": "NomicFoundation.hardhat-solidity"
  },
  "solidity.formatter": "forge",
  "solidity.compileUsingRemoteVersion": "v0.8.17"
}
```

Install dependencies

```bash
forge install foundry-rs/forge-std

forge install OpenZeppelin/openzeppelin-contracts

forge remappings > remappings.txt
```

## Dev

```bash
forge test
```

## Publish

Clean Artifacts

```bash
rm -rf cache out
```

Deploy

```bash
source .env && forge script --chain sepolia script/DeployDailyNotesLog.s.sol:DeployDailyNotesLog --rpc-url $SEPOLIA_RPC_URL --broadcast -vvvv
```

Deploy and Verify

```bash
source .env && forge script --chain sepolia script/DeployDAOVoting.s.sol:DeployDAOVoting --rpc-url $SEPOLIA_RPC_URL --broadcast --verify --verifier blockscout --verifier-url https://eth-sepolia.blockscout.com/api -vvvv
```

## Verify

```bash
https://eth-sepolia.blockscout.com/address/<address>/
```

```bash
forge verify-contract <address> SomeContract --watch
```
