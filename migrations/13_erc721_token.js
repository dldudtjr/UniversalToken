const ERC721Tokens = artifacts.require('./ERC721Token.sol');


module.exports = async function (deployer, network, accounts) {
  if (network == "test") return; // test maintains own contracts
  
   deployer.deploy(ERC721Tokens,'test1025','test1025','test1025','test1025');
  // console.log('\n   > ERC721Token token deployment: Success -->', ERC721Tokens.address);
};
