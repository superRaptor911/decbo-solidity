const UserContact = artifacts.require('UserContact.sol');
const truffleAssert = require('truffle-assertions');
const config = require('./config.json');

contract('UserContact', () => {
  it('Should add user', async () => {
    const contract = await UserContact.new();
    await contract.addUser(
      config.addresses[0],
      "Raptor",
     "raptor@gmail.com",
      "8505908858", 
    );
    // assert(true);
  });

  it('Should fail to add user', async () => {
    const contract = await UserContact.new();
    await contract.addUser(
      config.addresses[0],
      "Raptor",
      "raptor@gmail.com",
      "8505908858",
    );

    await contract.addUser(
      config.addresses[0],
      "Raptor",
      "raptor@gmail.com",
      "8505908858",
    );
  });

  it('Should get user', async () => {
    const contract = await UserContact.new();

    await contract.addUser(
      config.addresses[0],
      "Raptor",
      "raptor@gmail.com",
      "8505908858",
    );

    const result = await contract.getUser(
      config.addresses[0]
    );
    console.log(result);
  });

  it('Should fail to get user', async () => {
    const contract = await UserContact.new();
    await truffleAssert.fails(
      contract.getUser(config.addresses[0])
    );
  });
});
