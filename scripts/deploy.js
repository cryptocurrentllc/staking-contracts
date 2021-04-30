async function main() {
  // const Staking = await ethers.getContractFactory("Staking");
  
  const SingleStaking = await ethers.getContractFactory("SingleStaking");
  const htgAddress = "0x9E8F15280ec9EeE26859F6Cb23B9D1B5599BaB45" // change to htg address
  const ipfsLink = "https://gateway.pinata.cloud/ipfs/QmXcEJrmJWCcNpg2a1tRrm9BRZkKTn29Y5adsB4iRaF4ZG" // change to NFT metadata on IPFS
  
  // Start deployment, returning a promise that resolves to a contract object
  // const staking = await Staking.deploy(
  //   "0x9E8F15280ec9EeE26859F6Cb23B9D1B5599BaB45",
  //   "0xc012a49e04a1c12488DB28A35Eb59838a1718Fb0",
  //   "0x7a250d5630b4cf539739df2c5dacb4c659f2488d",
  //   "https://gateway.pinata.cloud/ipfs/QmXcEJrmJWCcNpg2a1tRrm9BRZkKTn29Y5adsB4iRaF4ZG",
  // );
  
  const singleStaking = await SingleStaking.deploy(htgAddress, ipfsLink);

  console.log("Contract deployed to address:", singleStaking.address);
}

main()
.then(() => process.exit(0))
.catch(error => {
  console.error(error);
  process.exit(1);
});