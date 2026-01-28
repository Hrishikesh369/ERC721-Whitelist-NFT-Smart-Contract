//SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {ReentrancyGuard} from "lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {Whitelist} from "./Whitelist.sol";

contract CryptoDevs is ERC721, ReentrancyGuard {
    Whitelist s_whitelist;
    address private s_owner;
    uint256 private s_tokenId;
    uint256 private constant COST_TO_MINT = 0.01 ether;
    uint256 public constant MAX_SUPPLY = 20;
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor(address whitelistContract) ERC721("CryptoDevs", "CD") {
        s_whitelist = Whitelist(whitelistContract);
        s_owner = msg.sender;
        s_tokenId = 0;
    }

    function mintNFT(string memory tokenUri) external payable nonReentrant {
        require(s_tokenId < MAX_SUPPLY, "Max Supply Reached");

        if (true == s_whitelist.checkWhitelistAccount(msg.sender)) {
            require(balanceOf(msg.sender) == 0, "Already Minted");
        } else {
            require(msg.value >= COST_TO_MINT, "The ether you sent is less, please send 0.01 ether to mint");
        }

        s_tokenIdToUri[s_tokenId] = tokenUri;
        _safeMint(msg.sender, s_tokenId);
        s_tokenId++;
    }

    function withdraw() public nonReentrant onlyOwner {
        (bool success,) = payable(s_owner).call{value: address(this).balance}("");
        require(success, "Transaction Failed");
    }

    modifier onlyOwner() {
        require(msg.sender == s_owner, "Only Owner function");
        _;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }
}
