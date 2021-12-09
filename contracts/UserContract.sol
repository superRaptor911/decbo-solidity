pragma solidity ^0.8.3;

contract UserContact {
    struct User {
        address id;
        string username;
        string email;
        string password;
        bool isValid; 
    }

    mapping(address => User) users;

    function getUser(address userAddr) external view returns (
        User memory usr
    ) {
        usr = users[userAddr];
        require(usr.isValid == true, "User not registered");
        return usr;
    }

    function addUser(
        address userAddr,
        string calldata name, 
        string calldata _email,
        string calldata _password
    ) external {
        require(users[userAddr].isValid == false ,
                "User already registered");

        users[userAddr] = User(
            userAddr,
            name,
            _email,
            _password,
            true
        );
    }
}
