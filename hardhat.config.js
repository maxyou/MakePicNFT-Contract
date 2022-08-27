require('@nomiclabs/hardhat-waffle');
require('dotenv').config();

module.exports = {
  solidity: '0.8.1',
  networks: {
    goerli: {
      url: process.env.ALCHEMY_HTTPS_GOERLI,
      accounts: [process.env.PRIVATE_KEY_GOERLI],
    },
    rinkeby: {
      url: process.env.ALCHEMY_HTTPS_RINKEBY,
      accounts: [process.env.PRIVATE_KEY_RINKEBY],
    },
  },
};