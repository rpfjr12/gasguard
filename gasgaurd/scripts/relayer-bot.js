import { ethers } from "ethers";
import abi from "./gasguard-abi.json" assert { type: "json" };

const provider = new ethers.JsonRpcProvider("http://127.0.0.1:8545");
const relayer = provider.getSigner(0);

const gasGuard = new ethers.Contract(
  "YOUR_LOCAL_GASGUARD_ADDRESS",
  abi,
  relayer
);

async function execute() {
  const tx = await gasGuard.performArbitrage(
    "TOKEN_A_ADDRESS",
    "TOKEN_B_ADDRESS",
    ethers.parseEther("1")
  );

  console.log("Sent:", tx.hash);
  await tx.wait();
  console.log("Done");
}

execute();
