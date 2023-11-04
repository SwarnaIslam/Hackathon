# Sample Hardhat Project
In the root directory make a .env files containing these information:
```shell
ALCHEMY_KEY_URL="API key URL for your Sepolia testnet project"
SEPOLIA_PRIVATE_KEY="Your private key of Sepolia test network"
```
Try running some of the following tasks:
From root directory:
```shell
yarn
npx hardhat compile
npx hardhat run --network sepolia scripts/deploy.js
```

Then run the React app following these commands:
```shell
cd client
yarn
npm start
```
