// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ABXToken is ERC20 {
    uint256 public conversionRate = 10000;
    uint256 public balance;

    constructor() ERC20("ABXToken", "ABX") {
        _mint(msg.sender, 1000000 * 10 ** 18); // Initial supply
        balance = 1000000;
    }

    function buyTokens() external payable {
        require(msg.value > 0, "Ether amount must be greater than 0");
        uint256 tokensToMint = msg.value * conversionRate; // Adjust conversion rate as needed
        _mint(msg.sender, tokensToMint);
    }

    function getBalance(address account) external view returns (uint256) {
        return balanceOf(account);
    }
}
