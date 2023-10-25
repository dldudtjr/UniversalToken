require('dotenv').config();
require('babel-register');
require('babel-polyfill');

const HDWalletProvider = require('truffle-hdwallet-provider');

const providerWithMnemonic = (mnemonic, rpcEndpoint) => () =>
  new HDWalletProvider(mnemonic, rpcEndpoint);

const infuraProvider = network => providerWithMnemonic(
  process.env.MNEMONIC || '',
  `https://${network}.infura.io/v3/${process.env.INFURA_API_KEY}`
);

const ropstenProvider = process.env.SOLIDITY_COVERAGE
  ? undefined
  : infuraProvider('ropsten');

module.exports = {
  networks: {
    neural: {
      host: '58.151.59.60',
      port: 9645,
      network_id: '140489472',   
      type: "quorum",
      gasPrice: 0x01,
      disableConfirmationListener: true,
    },
    aws: {
      host: '3.37.135.154',
      port: 9645,
      network_id: '140489472',   
      type: "quorum",
      gasPrice: 0x1999999999999,
      disableConfirmationListener: true,
    },
    development: {
      host: 'localhost',
      port: 9645,
      type: "quorum",
      network_id: '140489472', // eslint-disable-line camelcase
      gasPrice: 0x1999999999999,
      disableConfirmationListener: true,
    },
    test: {
      host: "localhost",
      port: 9645,
      network_id: '140489472',   
      type: "quorum",
      gasPrice: 0x01,
      // disableConfirmationListener: true,
    },
    ropsten: {
      provider: ropstenProvider,
      network_id: 3, // eslint-disable-line camelcase
      gasPrice: 5000000000,
    },
    coverage: {
      host: 'localhost',
      network_id: '*', // eslint-disable-line camelcase
      port: 8555,
      gas: 0xfffffffffff,
      gasPrice: 0x01,
      disableConfirmationListener: true,
    },
    ganache: {
      host: 'localhost',
      port: 7545,
      network_id: '*', // eslint-disable-line camelcase
    },
    dotEnvNetwork: {
      provider: providerWithMnemonic(
        process.env.MNEMONIC,
        process.env.RPC_ENDPOINT
      ),
      network_id: parseInt(process.env.NETWORK_ID) || '*', // eslint-disable-line camelcase
    },
  },
  plugins: ["solidity-coverage", "truffle-contract-size", "truffle-plugin-verify"],
  compilers: {
    solc: {
      version: '0.8.7',
      settings: {
        optimizer: {
          enabled: true, // Default: false
          runs: 0, // Default: 200
        },
      },
    },
  },
  api_keys: {
    etherscan: process.env.ETHERSCAN_API_KEY
  },
};
