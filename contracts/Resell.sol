// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ArtBlockMarket is ERC721Enumerable, Ownable {
    using SafeMath for uint256;

    struct NFTListing {
        uint256 tokenId;
        address seller;
        uint256 price;
        address originalCreator;
        uint256 creatorRoyaltyPercentage;
    }

    NFTListing[] public listings;

    mapping(uint256 => uint256) public tokenIdToListingIndex;

    event NFTListed(uint256 indexed tokenId, uint256 price);
    event NFTSold(uint256 indexed tokenId, address indexed seller, address indexed buyer, uint256 price);

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}

    function listNFT(uint256 tokenId, uint256 price, address originalCreator, uint256 creatorRoyaltyPercentage) public {
        require(_exists(tokenId), "Token does not exist");
        require(ownerOf(tokenId) == msg.sender, "You can only list NFTs you own");
        NFTListing memory newListing = NFTListing({
            tokenId: tokenId,
            seller: msg.sender,
            price: price,
            originalCreator: originalCreator,
            creatorRoyaltyPercentage: creatorRoyaltyPercentage
        });
        listings.push(newListing);
        tokenIdToListingIndex[tokenId] = listings.length - 1;
        emit NFTListed(tokenId, price);
    }

    function buyNFT(uint256 listingIndex) public payable {
        require(listingIndex < listings.length, "Invalid listing index");
        NFTListing storage listing = listings[listingIndex];
        require(msg.value >= listing.price, "Insufficient payment");
        uint256 creatorRoyalty = (listing.price * listing.creatorRoyaltyPercentage) / 100;
        uint256 sellerPayment = listing.price - creatorRoyalty;
        payable(listing.seller).transfer(sellerPayment);
        payable(listing.originalCreator).transfer(creatorRoyalty);

        _transfer(listing.seller, msg.sender, listing.tokenId);
        removeListing(listingIndex);
        emit NFTSold(listing.tokenId, listing.seller, msg.sender, listing.price);
    }

    function removeListing(uint256 listingIndex) internal {
        require(listingIndex < listings.length, "Invalid listing index");
        uint256 tokenId = listings[listingIndex].tokenId;
        delete tokenIdToListingIndex[tokenId];
        if (listingIndex < listings.length - 1) {
            listings[listingIndex] = listings[listings.length - 1];
            tokenIdToListingIndex[listings[listings.length - 1].tokenId] = listingIndex;
        }
        listings.pop();
    }
}
