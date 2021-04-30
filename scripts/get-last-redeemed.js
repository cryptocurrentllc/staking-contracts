require('dotenv').config();

const API_URL = process.env.API_URL;
const PUBLIC_KEY = process.env.PUBLIC_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
const web3 = createAlchemyWeb3(API_URL);

const contract = require("../artifacts/contracts/SingleStaking.sol/SingleStaking.json");
const contractAddress = process.env.CONTRACT_ADDRESS;
const nftContract = new web3.eth.Contract(contract.abi, contractAddress);

async function getLastRedeemed() {
  nftContract.methods.lastRedeemed("0xfA3354A4660aCE44C94aE5D030Db98374F41a763").call((err, result) => {
    if (!err) {
      console.log("The result of your transaction is: ", result); 
    } else {
      console.log("Something went wrong when submitting your transaction:", err)
    }
  });
}

getLastRedeemed();