const UserContact = artifacts.require('UserContact.sol');
const truffleAssert = require('truffle-assertions');

contract('UserContact', () => {
  it('Should add user', async () => {
    const contract = await UserContact.new();
    await contract.addUser(
      "0xd5AAa73e6895fb7c887b3fA1f8232b7494d7D67F",
      "Raptor",
      "raptor@gmail.com",
      "intel"
    );
    // assert(true);
  });

  it('Should fail to add user', async () => {
    const contract = await UserContact.new();
    await contract.addUser(
      "0xd5AAa73e6895fb7c887b3fA1f8232b7494d7D67F",
      "Raptor",
      "raptor@gmail.com",
      "intel"
    );

    await contract.addUser(
      "0xd5AAa73e6895fb7c887b3fA1f8232b7494d7D67F",
      "Raptor",
      "raptor@gmail.com",
      "intel"
    );
  });

  it('Should get user', async () => {
    const contract = await UserContact.new();

    await contract.addUser(
      "0xd5AAa73e6895fb7c887b3fA1f8232b7494d7D67F",
      "Raptor",
      "raptor@gmail.com",
      "intel"
    );

    const result = await contract.getUser(
      "0xd5AAa73e6895fb7c887b3fA1f8232b7494d7D67F"
    );
    console.log(result);
  });

  it('Should fail to get user', async () => {
    const contract = await UserContact.new();
    await truffleAssert.fails(
      contract.getUser("0xd5AAa73e6895fb7c887b3fA1f8232b7494d7D67F")
    );
  });
});
