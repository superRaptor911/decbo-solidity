pragma solidity ^0.8.3;

import "./lib/Utility.sol";

contract Rooms {
    struct File {
        uint fileId;
        string fileHash;
        uint fileSize;
        string fileType;
    }

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
        uint price;

        File previewImage1;
        File previewImage2;
        File previewImage3;
        File previewImage4;
        File previewImage5;
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
        Room memory room;
        room.id = id;
        room.seller = msg.sender;
        room.name = name;
        room.city = city;
        room.state = state;
        room.country = country;
        room.description = description;
        room.capacity = capacity;
        room.isValid = true;
        rooms[id] = room;
    }

    // Function to add media
    function addMedia(uint id, File[5] calldata files) external {
        require(rooms[id].isValid, "Room does not exist");
        require(rooms[id].seller == msg.sender, "Only owner can modify");

        rooms[id].previewImage1 = files[0];
        rooms[id].previewImage2 = files[1];
        rooms[id].previewImage3 = files[2];
        rooms[id].previewImage4 = files[3];
        rooms[id].previewImage5 = files[4];
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

        Room memory room;
        room.id = id;
        room.seller = msg.sender;
        room.name = name;
        room.city = city;
        room.state = state;
        room.country = country;
        room.description = description;
        room.capacity = capacity;
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
