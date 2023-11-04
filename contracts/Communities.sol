// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./Community.sol";

contract Communities {
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
        uint256 initialTokens,
        uint conversionRate,
        string memory name,
        string memory symbol
    ) public {
        Community comm = new Community(
            title1,
            description1,
            initialTokens,
            conversionRate,
            name,
            symbol
        );
        Community1 memory comm1 = Community1({
            name: title1,
            addr: address(comm),
            tokenAddress: comm.nativeTokenAddress()
        });
        CommunityList.push(comm1);
    }
    //0xa6869f18e899E9738Eed0AF73c4b3Ca9d8c59A86
}
