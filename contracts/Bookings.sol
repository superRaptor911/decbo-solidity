pragma solidity ^0.8.3;


contract RoomsProxy {
    struct File {
        string path;
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
        bool isValid;
    }

    // Get room by id
    function getRoom(uint id) external view returns (Room memory room) {}
    function bookRoom(uint id) external {}
    function unbookRoom(uint id) external {}
    function isValidRoomAndNotBooked(uint id) external view returns (bool) {}
}


contract Bookings {
    struct Timings {
        uint time_createdOn;
        uint time_bookedFrom;
        uint time_bookedTill;
    }

    struct Booking {
        uint id;
        address seller;
        address buyer;
        uint roomId;
        uint price;
        Timings timings;
        bool signedByBuyer;
        bool signedBySeller;
        bool isValid; 
    }
    
    RoomsProxy RoomsContract;

    mapping(uint => Booking) bookings;
    uint bookingsCount;
    
    constructor(address RoomsContractAddress) {
        RoomsContract = RoomsProxy(RoomsContractAddress);
    }

    function getBooking(uint id) external view returns (
        Booking memory 
    ) {
        require(bookings[id].isValid == true, "Invalid booking id");
        return bookings[id];
    }

    function createBooking(
        address seller,
        uint roomId,
        uint price,
        Timings calldata timings
    ) external {
        require(RoomsContract.isValidRoomAndNotBooked(roomId) == true ,
        "Rood does not exists or is booked");
        RoomsContract.bookRoom(roomId);
        bookings[bookingsCount] = Booking(
            bookingsCount,
            seller,
            msg.sender,
            roomId,
            price,
            timings,false, true, true);

    }
}
