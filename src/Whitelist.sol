// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

contract Whitelist {
    uint8 public s_maxWhitelistAddress;
    uint8 private s_addressCounter;
    mapping(address => bool) public s_isWhiteListed;

    event addressAddedToWhitelist(address indexed userAddr);

    constructor() {
        s_maxWhitelistAddress = 10;
    }

    function addAddressToWhitelist() external {
        require(!s_isWhiteListed[msg.sender], "Address already exists in the Whitelist");
        require(s_addressCounter < s_maxWhitelistAddress, "Whitelist is full with 10 Addresses");
        s_isWhiteListed[msg.sender] = true;
        s_addressCounter++;
        emit addressAddedToWhitelist(msg.sender);
    }

    function checkWhitelistAccount(address user) public view returns (bool) {
        return s_isWhiteListed[user];
    }
}

