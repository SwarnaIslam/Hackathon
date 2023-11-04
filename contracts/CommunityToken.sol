// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./ABXToken.sol";

contract CommunityToken is ERC20 {
    ABXToken public abxToken;
    uint conversionRate = 100;

    constructor(
        string memory name,
        string memory symbol,
        uint amount
    ) ERC20(name, symbol) {
        address abxAddress = 0x38b23C06BE9c1BEe388305153737F3de98a763e5;
        abxToken = ABXToken(abxAddress);
        _mint(msg.sender, amount * 10 ** 18); // Initial supply
    }

    function buyCommunityTokens(uint paidABX, address community) external {
        require(paidABX > 0, "Token amount must be greater than 0");
        abxToken.transferFrom(msg.sender, community, paidABX);
        uint256 tokensToMint = paidABX * conversionRate; // Adjust conversion rate as needed
        _mint(msg.sender, tokensToMint);
    }
}
