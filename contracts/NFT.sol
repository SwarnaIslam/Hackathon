// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyNFT is  ERC721, Ownable {
    
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    struct NFTMetadata {
        string name;
        string description;
        string imageCID;  // This will store the IPFS CID of the image
    }

    // Mapping from token ID to NFT metadata
    mapping(uint256 => NFTMetadata) public tokenMetadata;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}

    function mintNFT(address to, uint256 tokenId, string memory name, string memory description, string memory imageCID) public onlyOwner {
        _mint(to, tokenId);

        NFTMetadata memory metadata = NFTMetadata({
            name: name,
            description: description,
            imageCID: imageCID
        });

        tokenMetadata[tokenId] = metadata;
    }
}
