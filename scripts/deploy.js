const hre = require("hardhat");

async function main() {
  const donate = await hre.ethers.getContractFactory("Communities");
  const contract = await donate.deploy();
  await contract.waitForDeployment();
  console.log("Address of contract: ", contract.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
