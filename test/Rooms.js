const Rooms = artifacts.require('Rooms.sol');
const truffleAssert = require('truffle-assertions');
const config = require('./config.json');

async function addRooms(contract, count) {
  for (let i = 0; i < count; i++) {
    await contract.addRoom(
      config.addresses[0],
      "Raptors mansion",
      "Noida",
      "UP",
      "India",
    );
  }
}


function randi(till) {
  return Math.floor(Math.random() * till);
}

async function addRoomsRandom(contract, count) {
  const names = ["raptor mansion", "tharavad", "kottaram", "chinnaveddu", "kalliveddu"];
  const cities = ["Noida", "Kollam", "Kannur", "Kottayam", "Bangalore", "Delhi"];
  const states = ["UP", "Delhi", "Kerala", "Maharashtra", "Orissa", "Assam"];

  for (let i = 0; i < count; i++) {
    await contract.addRoom(
      config.addresses[0],
      names[randi(names.length)],
      cities[randi(cities.length)],
      states[randi(states.length)],
      "India",
    );
  }
}

contract('Rooms', () => {
  it('Should add room', async () => {
    const contract = await Rooms.new();
    await contract.addRoom(
      config.addresses[0],
      "Raptors mansion",
      "Noida",
      "UP",
      "India",
    );
  });


  it('Should get room', async () => {
    const contract = await Rooms.new();
    await contract.addRoom(
      config.addresses[0],
      "Raptors mansion",
      "Noida",
      "UP",
      "India",
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
    const result = await contract.getLatestRooms(0);
    console.log(result)
  });


  it('Should list rooms by latest with pagination', async () => {
    const contract = await Rooms.new();
    await addRooms(contract, 35);
    const result = await contract.getLatestRooms(1);
    console.log(result)
  });


  it('Should list rooms by city query', async () => {
    const contract = await Rooms.new();
    await addRoomsRandom(contract, 10); 
    const result = await contract.getRoomsInCity("Noida");
    console.log(result)
  });

  it('Should list rooms by state query', async () => {
    const contract = await Rooms.new();
    await addRoomsRandom(contract, 10); 
    const result = await contract.getRoomsInState("Kerala");
    console.log(result)
  });
});
