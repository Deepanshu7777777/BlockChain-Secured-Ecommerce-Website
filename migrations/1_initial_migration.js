//This file is used to deploy the Migrations smart contract to the blockchain.
//the Migrations smart contract is imported using the artifacts.require function, which looks for the Migrations contract in the ./Migrations.sol file.

var Migrations = artifacts.require("./Migrations.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
