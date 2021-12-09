const Voting = artifacts.require('Voting.sol');
const UserContact = artifacts.require('UserContact.sol');

module.exports = function (deployer) {
  deployer.deploy(Voting);
  deployer.deploy(UserContact);
};
