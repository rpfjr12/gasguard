const hre = require("hardhat");

async function main() {
  const ProfitHandler = await hre.ethers.deployContract("ProfitHandler");
  await ProfitHandler.waitForDeployment();

  const GasGuard = await hre.ethers.deployContract("GasGuard", [
    await ProfitHandler.getAddress()
  ]);
  await GasGuard.waitForDeployment();

  console.log("ProfitHandler:", await ProfitHandler.getAddress());
  console.log("GasGuard:", await GasGuard.getAddress());
}

main();
