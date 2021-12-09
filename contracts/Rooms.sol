pragma solidity ^0.8.3;

import "../lib/StringMan.sol";

contract Rooms {
    // Room Struct
    struct Room {
        uint id;
        address seller;
        string name;
        string fullAddress;
        bool isValid;
    }

    mapping(uint => Room) rooms;
    // Number of rooms in contract
    uint roomCount = 0;

    // Get room by id
    function getRoom(uint id) external view returns (Room memory room) {
        room = rooms[id];
        require(room.isValid == true, "Room not found");
        return room;
    }

    // Add a new room
    function addRoom(address seller, string calldata name, string calldata fullAddress) external {
        uint id = roomCount;
        Room memory room = Room(id, seller, name, fullAddress, true);
        roomCount++;
        rooms[id] = room;
    }

    // List rooms by search criteria
    // filterType 1 latest, 2 
    function listRooms(
        uint filterType,
        string calldata query, uint page)
        external view returns (Room[] memory filteredRooms) {
        require(filterType <= 2, "Invalid filter option");

        if (filterType == 0) {
            return mGetSearchResults(query);
        }
        // Latest
        return mGetLatest(page);
    }

    // Get Latest Rooms
    function mGetLatest(uint page) view private returns (Room[] memory){
        // Max results = 32, so allocate 32
        Room[] memory list = new Room[](32);
        uint offset = 32 * page;                // Offset, i.e starting point
        uint end = 32 + offset;                 // end

        require(offset < roomCount, "No more rooms");   // check if offset > roomcount
        end = end > roomCount ? roomCount : end;        // end should not be more than room count

        // Backward Loop
        for(uint i = end; i >= offset; i--) {
            list[i - 32 - offset] = rooms[i - 1];
        }
        return list;
    }


    function mGetSearchResults( string calldata query) private view returns(Room[] memory) {
            uint[] memory matchlevels = new uint[](roomCount);
            uint resultCount = 0;

            for(uint i = 0; i < roomCount; i++) {
                uint matchLevel = Utility.geStrMatchLevel(
                    rooms[i].fullAddress,
                    query
                );
                matchlevels[i] = matchLevel;
                if (matchLevel > 0) {
                    resultCount++;
                }
            }

            // Utility.sortUintArr(matchlevels, false);
            Room[] memory results = new Room[](resultCount);
            uint index = 0;
            for(uint i = 0; i < roomCount; i++) {
                if (matchlevels[i] != 0) {
                    results[index] = rooms[i]; 
                    index++;
                }
            }
            return results;
    }
}
