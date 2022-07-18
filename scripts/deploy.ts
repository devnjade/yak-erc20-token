import { ethers } from "hardhat";

async function main() {
  const YakToken = await ethers.getContractFactory("YakToken");
  const yakToken = await YakToken.deploy();

  await yakToken.deployed();

  console.log("YakToken deployed to:", yakToken.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});