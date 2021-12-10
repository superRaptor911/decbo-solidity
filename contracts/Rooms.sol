pragma solidity ^0.8.3;

import "./lib/Utility.sol";

contract Rooms {
    // Room Struct
    struct Room {
        uint id;
        address seller;
        string name;
        string city;
        string state;
        string country;
        string description;
        uint capacity;
        bool isValid;
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

    // Add a new room
    function addRoom(
        string calldata name,
        string calldata city,
        string calldata state,
        string calldata country,
        string calldata description,
        uint capacity
    ) external {
        uint id = roomCount;
        roomCount++;
        rooms[id] = Room(id, msg.sender, name, city, state, country, description, capacity, true);
    }

    // Update room
    function updateRoom(
        uint id,
        string calldata name,
        string calldata city,
        string calldata state,
        string calldata country,
        string calldata description,
        uint capacity
    ) external {
        require(rooms[id].isValid, "Room does not exist");
        require(rooms[id].seller == msg.sender, "Only owner can modify");
        rooms[id] = Room(id, msg.sender, name, city, state, country, description, capacity, true);
    }

    // Get rooms in city
    function getRoomsInCity(string calldata city) external view returns (
        Room[] memory) {
        // Array to hold Id's of rooms in the city
        uint[] memory ids = new uint[](roomCount);
        uint index = 0;
        for(uint i = 0; i < roomCount; i++) {
            if (Utility.strcmp(city, rooms[i].city)) {
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
            if (Utility.strcmp(state, rooms[i].state)) {
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
