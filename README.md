# ERC721 - NFT Using Whitelist

A ERC721 Solidity Smart Contract built on Foundry development framework.

## Overview

The "CryptoDev" smart contract is a collection of 20 mintable NFT's, it uses ERC721 standard functions which it inherits from "OpenZeppelin". This contract implements a "Whitelist" smart contract which allows 10 early users to mint free NFT's, the users who miss being included on this whitelist have to pay 0.01 ether to mint an NFT. NFT metadata stored on "IPFS".

## Functionality

***Whitelist Contract -***

**```constructor()```**

- Initializes the contract by setting s_maxWhitelistAddress = 10.

**```addAddressToWhitelist() external```**

- Adds msg.sender to the whitelist. Reverts if the sender is already whitelisted or the whitelist is full (s_addressCounter >= s_maxWhitelistAddress). On success sets s_isWhiteListed[msg.sender] = true, increments s_addressCounter, and emits addressAddedToWhitelist(msg.sender).

**```checkWhitelistAccount(address user) public view returns (bool)```**

- Read-only helper that returns whether user is whitelisted (s_isWhiteListed[user]). (Note: the public mapping s_isWhiteListed already provides an automatic getter.)

***CryptoDevs Contract -***

**```constructor(address whitelistContract) ERC721("CryptoDevs", "CD")```**

- Sets the Whitelist contract reference (s_whitelist = Whitelist(whitelistContract)), records deployer as s_owner, and initializes s_tokenId = 0.

**```mintNFT(string memory tokenUri) external payable nonReentrant```**

- Mints a new NFT with tokenUri mapped to the current s_tokenId. Reverts if s_tokenId >= MAX_SUPPLY. If caller is whitelisted (s_whitelist.checkWhitelistAccount(msg.sender) == true) it requires the caller owns zero tokens (free, one-per-whitelisted-address); otherwise it requires msg.value >= COST_TO_MINT. Calls _safeMint(msg.sender, s_tokenId) and increments s_tokenId. nonReentrant protects against reentrancy.

**```withdraw() public nonReentrant onlyOwner```**

- Owner-only function that transfers the contract’s entire ETH balance to s_owner using a low-level call. Reverts if the transfer fails.

**```tokenURI(uint256 tokenId) public view override returns (string memory)```**

- Returns the stored URI for tokenId from s_tokenIdToUri[tokenId]. (Note: implementation does not check _exists(tokenId) before returning.)

## Interact

Interact with Whitelist and CryptoDev contracts deployed on Sepolia at Etherscan -

https://sepolia.etherscan.io/address/0xC5d2dEaFB7dA477833666c2ce95cC0C7dA7330aa#code

https://sepolia.etherscan.io/address/0x075fF507e1e632AA641e9A9EC3c72f8309A7f9D8#code
