module.exports = async function(callback) {
  try {
    const ERC20HoldableToken = artifacts.require("ERC20HoldableToken");

    const from = "0x64397283445258612c4f265ab85b7b7c8321a53e";

    const erc20 = await ERC20HoldableToken.new("Test Holdable ERC20", "TEST", 18, {from: "0x64397283445258612c4f265ab85b7b7c8321a53e"});

    await erc20.mint("0x64397283445258612c4f265ab85b7b7c8321a53e", '1000000000000000000000000000');
    
    console.log("ERC20HoldableToken deployed at: " + erc20.address);

    callback();
  } catch (e) {
    callback(e);
  }
}