require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const PRIVATE_KEY = process.env.PRIVATE_KEY;

if (!PRIVATE_KEY || PRIVATE_KEY.length !== 64) {
  console.error("Please set a valid PRIVATE_KEY in your .env file");
  process.exit(1);
}

module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.20",
      },
      {
        version: "0.8.24",
      },
    ],
  },
  networks: {
    baseGoerli: {
      url: "https://goerli.base.org",
      accounts: [`0x${PRIVATE_KEY}`],
      gasPrice: 1000000000,
    },
  },
};