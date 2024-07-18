const hre = require("hardhat");

async function main() {
  const EcoHarvest = await hre.ethers.getContractFactory("EcoHarvest");
  const ecoHarvest = await EcoHarvest.deploy();

  await ecoHarvest.deployed();

  console.log("EcoHarvest deployed to:", ecoHarvest.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});