const keyMng =
  artifacts.require('./Keymng.sol');

module.exports = (deployer) => {
  deployer.deploy(keyMng);
};
