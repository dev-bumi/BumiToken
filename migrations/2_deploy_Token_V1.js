const { deployProxy } = require('@openzeppelin/truffle-upgrades');

const Token_V1 = artifacts.require('Token_V1');

module.exports = async function (deployer) {
  await deployProxy(Token_V1, [], { deployer, initializer: 'initt' });
};