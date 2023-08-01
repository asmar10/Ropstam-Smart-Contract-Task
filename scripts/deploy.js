
const hre = require("hardhat");

async function main() {

  /* for Ropstam contract*/
  const tokenPrice = 100;
  const maxSupply = hre.ethers.parseEther("1000");
  const ropstam = await hre.ethers.deployContract("Ropstam", [tokenPrice, maxSupply]);
  await ropstam.waitForDeployment();
  console.log(`Ropstam Token deployed at ${ropstam.target}`);

  /* for OpenHammer contract*/
  const Price = hre.ethers.parseEther("100");
  const ropstamTokenAddress = ropstam.target;
  const baseUri = "https://ipfs.io/ipfs/QmUPabH2yncKtRX536tVMd14VEo4RpUF15ATsVw8n3ryH1/"
  const owners = []

  const openhammer = await hre.ethers.deployContract("OpenHammer", [Price, ropstamTokenAddress, baseUri, owners]);
  await openhammer.waitForDeployment();
  console.log(`OpenHammer deployed at ${openhammer.target}`);

}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
