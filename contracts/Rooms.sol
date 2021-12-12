pragma solidity ^0.8.3;

import "./lib/Utility.sol";

contract Rooms {
    struct Images {
        string img1;
        string img2;
        string img3;
    }

    struct Address {
        string city;
        string state;
        string country;
    }

    // Room Struct
    struct Room {
        uint id;
        string name;
        address seller;
        Address roomAddress;
        string description;
        uint capacity;
        uint price;

        Images images;
        bool isValid;
        bool isBooked;
    }

    mapping(uint => Room) rooms;
    // Number of rooms in contract
    uint public roomCount = 0;

    // Get room by id
    function getRoom(uint id) external view returns (Room memory room) {
        require(id < roomCount, "Room not found");
        room = rooms[id];
        return room;
    }

    function isValidRoomAndNotBooked(uint id) external view returns (bool) {
        return id < roomCount && !rooms[id].isBooked;
    }

    function bookRoom(uint id) external {
        require(id < roomCount, "Room not found");
        require(!rooms[id].isBooked, "Room already booked");
        rooms[id].isBooked = true;
    }

    function unbookRoom(uint id) external {
        require(id < roomCount, "Room not found");
        rooms[id].isBooked = false;
    }

    // Add a new room
    function addRoom(
        string calldata name,
        Address calldata roomAddress,
        string calldata description,
        uint capacity,
        uint price,
        Images memory images
    ) external {
        uint id = roomCount;
        roomCount++;
        Room memory room;
        room.id = id;
        room.seller = msg.sender;
        room.name = name;
        room.roomAddress = roomAddress;

        room.description = description;
        room.capacity = capacity;
        room.isValid = true;
        room.price = price;
        room.images = images;
        rooms[id] = room;

    }

    // Update room
    function updateRoom(
        uint id,
        string calldata name,
        Address calldata roomAddress,
        string calldata description,
        uint price,
        uint capacity
    ) external {
        require(rooms[id].isValid, "Room does not exist");
        require(rooms[id].seller == msg.sender, "Only owner can modify");

        Room memory room;
        room.id = id;
        room.seller = msg.sender;
        room.name = name;
        room.roomAddress = roomAddress;
        room.description = description;
        room.capacity = capacity;
        room.price = price;
        room.isValid = true;
        rooms[id] = room;
    }

    // Get rooms in city
    function getRoomsInCity(string calldata city) external view returns (
        Room[] memory) {
        // Array to hold Id's of rooms in the city
        uint[] memory ids = new uint[](roomCount);
        uint index = 0;
        for(uint i = 0; i < roomCount; i++) {
            if (Utility.strcmp(city, rooms[i].roomAddress.city)) {
                ids[index] = i;
                index++;
            }
        }

        // Allocate memory for Rooms
        Room[] memory roomsInCity = new Room[](index);
        // Add rooms
        for(uint i = 0; i < index; i++) {
            roomsInCity[i] = rooms[ids[i]];
        }
        return roomsInCity;
    }


    // Get rooms in State
    function getRoomsInState(string calldata state) external view returns (
        Room[] memory) {
        // Array to hold Id's of rooms in the state
        uint[] memory ids = new uint[](roomCount);
        uint index = 0;
        for(uint i = 0; i < roomCount; i++) {
            if (Utility.strcmp(state, rooms[i].roomAddress.state)) {
                ids[index] = i;
                index++;
            }
        }

        // Allocate memory for Rooms
        Room[] memory roomsInState = new Room[](index);
        // Add rooms
        for(uint i = 0; i < index; i++) {
            roomsInState[i] = rooms[ids[i]];
        }
        return roomsInState;
    }

    // Get Latest Rooms
    function getLatestRooms(uint page) view external returns (Room[] memory){
        uint offset = 32 * page;                // Offset, i.e starting point
        uint end = 32 + offset;                 // end

        require(offset < roomCount, "No more rooms");   // check if offset > roomcount
        end = end > roomCount ? roomCount : end;        // end should not be more than room count

        // Max results = 32, so allocate 32
        Room[] memory list = new Room[](end - offset);
        // Backward Loop
        for(uint i = end; i > offset; i--) {
            list[end - i] = rooms[i - 1];
        }
        return list;
    }
}
