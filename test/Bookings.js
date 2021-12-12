const Rooms = artifacts.require('Rooms.sol');
const Bookings = artifacts.require('Bookings.sol');
const truffleAssert = require('truffle-assertions');
const config = require('./config.json');

async function addRooms(contract, count) {
  for (let i = 0; i < count; i++) {
    await contract.addRoom(
      "Raptors mansion",
      {city: "Noida", state: "UP", country: "India"},
      "desc",
      4,
      100,
      {img1: "asdda", img2: "asdda", img3: "asdda"}
    );
  }
}

contract('Bookings', () => {
  it('Should be able to create booking', async () => {
    const roomContract = await Rooms.new();
    await addRooms(roomContract, 1);

    const contract = await Bookings.new(roomContract.address);
    const result = await contract.createBooking(config.addresses[0], 0, 100, {
      time_createdOn: 1000,
      time_bookedFrom: 1000,
      time_bookedTill: 1000,
    })

    console.log(result)
  });

  it('Should not be able to create booking', async () => {
    const roomContract = await Rooms.new();
    await addRooms(roomContract, 1);

    const contract = await Bookings.new(roomContract.address);
    let result = await contract.createBooking(config.addresses[0], 0, 100, {
      time_createdOn: 1000,
      time_bookedFrom: 1000,
      time_bookedTill: 1000,
    })

    result = await contract.createBooking(config.addresses[0], 0, 100, {
      time_createdOn: 1000,
      time_bookedFrom: 1000,
      time_bookedTill: 1000,
    })

    console.log(result)
  });

  it('Should list pending bookings', async () => {
    const roomContract = await Rooms.new();
    await addRooms(roomContract, 3);

    const contract = await Bookings.new(roomContract.address);
    await contract.createBooking(config.addresses[0], 0, 100, {
      time_createdOn: 1000,
      time_bookedFrom: 1000,
      time_bookedTill: 1000,
    })

    await contract.createBooking(config.addresses[0], 1, 100, {
      time_createdOn: 1000,
      time_bookedFrom: 1000,
      time_bookedTill: 1000,
    })

    await contract.createBooking(config.addresses[0], 2, 100, {
      time_createdOn: 1000,
      time_bookedFrom: 1000,
      time_bookedTill: 1000,
    })

    const result = await contract.getPendingContractsBuyer(config.addresses[0])
    console.log(result)
    assert(result.length > 0)
  });
});
