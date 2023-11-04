// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./Community.sol";
import "./CommunityToken.sol";

contract Communities {
    address tempToken;
    struct Community1 {
        address addr;
        string name;
        address tokenAddress;
    }
    Community1[] CommunityList;

    constructor() {}

    function createCommunity(
        string memory title1,
        string memory description1,
        uint initialTokens
    ) public payable {
        Community comm = new Community(
            title1,
            description1,
            tempToken,
            initialTokens
        );
        addToList(title1, address(comm), tempToken);
    }

    function createCommunityToken(
        uint256 initialTokens,
        uint conversionRate,
        string memory name,
        string memory symbol
    ) public payable {
        CommunityToken token = new CommunityToken(
            name,
            symbol,
            initialTokens * conversionRate
        );
        tempToken = address(token);
    }

    function addToList(
        string memory name1,
        address communityAddress,
        address tokenAddress1
    ) public {
        Community1 memory comm1 = Community1({
            name: name1,
            addr: communityAddress,
            tokenAddress: tokenAddress1
        });
        CommunityList.push(comm1);
    }

    //0xa6869f18e899E9738Eed0AF73c4b3Ca9d8c59A86
}
