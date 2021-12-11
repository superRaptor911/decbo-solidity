const Rooms = artifacts.require('Rooms.sol');
const Utility = artifacts.require('Utility.sol');
const UserContact = artifacts.require('UserContact.sol');
const Bookings = artifacts.require('Bookings.sol');

module.exports = function (deployer) {
  deployer.deploy(UserContact);

  deployer.deploy(Utility).then(() => {
        deployer.link(Utility, Rooms);
        return deployer.deploy(Rooms);
  }).then(() => {
        return deployer.deploy(Bookings, Rooms.address);
  });
};
