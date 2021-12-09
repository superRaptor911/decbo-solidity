const Rooms = artifacts.require('Rooms.sol');
const truffleAssert = require('truffle-assertions');
const config = require('./config.json');

async function addRooms(contract, count) {
  for (let i = 0; i < count; i++) {
    await contract.addRoom(
      config.addresses[0],
      "Raptors mansion",
      "c-12/14 sector 71 noida, UP",
    );
  }
}

contract('Rooms', () => {
  it('Should add room', async () => {
    const contract = await Rooms.new();
    await contract.addRoom(
      config.addresses[0],
      "Raptors mansion",
      "c-12/14 sector 71 noida, UP",
    );
  });


  it('Should get room', async () => {
    const contract = await Rooms.new();
    await contract.addRoom(
      config.addresses[0],
      "Raptors mansion",
      "c-12/14 sector 71 noida, UP",
    );

    const result = await contract.getRoom(0);
    console.log(result);
  });

  it('Should fail to get room', async () => {
    const contract = await Rooms.new();
    await truffleAssert.fails(contract.getRoom(0));
  });

  it('Should fail to get room', async () => {
    const contract = await Rooms.new();
    await truffleAssert.fails(contract.getRoom(0));
  });

  it('Should have correct room count', async () => {
    const contract = await Rooms.new();
    await addRooms(contract, 5);
    const result = await contract.roomCount();
    assert(result == 5);
  });

  it('Should list rooms by latest', async () => {
    const contract = await Rooms.new();
    await addRooms(contract, 3);
    const result = await contract.listRooms(
      1,
      "",
      0
    );
    console.log(result)
  });


  it('Should list rooms by latest with pagination', async () => {
    const contract = await Rooms.new();
    await addRooms(contract, 35);
    const result = await contract.listRooms(
      1,
      "",
      1
    );
    console.log(result)
  });


  it('Should list rooms by search query', async () => {
    const contract = await Rooms.new();
    await contract.addRoom(
      config.addresses[0],
      "Raptors mansion",
      "c-12/14 sector 71 noida, UP",
    );

    await contract.addRoom(
      config.addresses[0],
      "Raptors mansion",
      "c-12/14 71 kollam, UP",
    );
    const result = await contract.listRooms(
      0,
      "kollam sector",
      0
    );
    console.log(result)
  });
});
