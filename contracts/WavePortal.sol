// SPDX-Licence-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalMessages;

    // use this to help generate a random number
    uint256 private seed;

    /*
    Event is an inheritable member of a contract. An event is emitted, it stores the arguments passed in transaction logs.
    These logs are stored on blockchain and are accessible using address of the contract till the contract is present on the blockchain.
    An event generated is not accessible from within contracts, not even the one which have created and emitted them.
    */
    event NewMessage(address indexed from, uint256 timestamp, string message);

    /*
    A struct is a custom datatype where you customise what you want to hold inside it
    */
    struct Message {
        address mesg; // Address of who sent message
        string message; // The message that was sent
        uint256 timestamp; // The time it was sent
    }

    /*
    Declare messages which stores an array of structs.
    This is what holds all the messages people send.
    */

    Message[] messages;

    /*
    This is an address => uint maaping where I can associate an address
    with a number. Store the address with the last time a user sent a message.
    */

    mapping(address => uint256) public lastMessaged;

    constructor() payable {
        console.log("I am a smart contract");

        // set the initial seed
        seed = (block.timestamp + block.difficulty) % 100;
    }

    /*
    The function requires a string called _message, which is the message the user sends from the front-end.
    */

    function message(string memory _message) public {
        /*
        We need to make sure the current timestamp is at least 15 minutes bigger than
        the last timestamp we stored.
        */

        require(
            lastMessaged[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

        // Update the current timestamp we have for the user
        lastMessaged[msg.sender] = block.timestamp;

        totalMessages += 1;

        // msg.sender is wallet address of person who called the function
        console.log("% has sent a message!", msg.sender);

        // This is where the message data is stored in the array
        messages.push(Message(msg.sender, _message, block.timestamp));

        // Generate a new seed for the next user that sends a message
        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);

        // Give a 50% chance that the user will win the prize
        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        // Emit the event
        emit NewMessage(msg.sender, block.timestamp, _message);
    }

    /*
    This function returns the struct array, messages so we can retrieve the messages from the site.
    */

    function getAllMsg() public view returns (Message[] memory) {
        return messages;
    }

    function getTotalMessages() public view returns (uint256) {
        console.log("We have %d total messages!", totalMessages);
        return totalMessages;
    }
}
