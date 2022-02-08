// SPDX-Licence-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalMessages;

    constructor() {
        console.log("I am a smart contract");
    }
<<<<<<< HEAD
}

// comment
=======

    function message() public {
        totalMessages += 1;

        // msg.sender is wallet address of person who called the function
        console.log("% has sent a message!", msg.sender);
    }

    function getTotalMessages() public view returns (uint256) {
        console.log("We have %d total messages!", totalMessages);
        return totalMessages;
    }
}
>>>>>>> a98f32a2e3d560abe4a34a03563a693adfbc2d16
