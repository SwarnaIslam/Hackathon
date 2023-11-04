// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./ABXToken.sol";
import "./CommunityToken.sol";

contract Community {
    address public owner;
    ABXToken public abxToken;
    string title;
    string description;
    address public myAddress;
    // uint votingPeriod;
    // struct Post {
    //     uint postID;
    //     address publisher;
    //     string itemType;
    //     string status;
    //     uint createdTime;
    //     uint endTime;
    //     uint price;
    //     uint upvote;
    //     uint downvote;
    // }
    // Post[] private postList;
    // Post private newPost;

    CommunityToken public myCommunityToken;
    address public nativeTokenAddress;

    constructor(
        string memory title1,
        string memory description1,
        address tokenAddress,
        uint256 initialTokens
    ) {
        title = title1;
        description = description1;
        owner = msg.sender;
        //address abxAddress = "0x38b23C06BE9c1BEe388305153737F3de98a763e5";
        address abxAddress = 0x38b23C06BE9c1BEe388305153737F3de98a763e5;

        abxToken = ABXToken(abxAddress);
        // Transfer initial tokens to this contract
        abxToken.transferFrom(msg.sender, address(this), initialTokens);
        myCommunityToken = CommunityToken(tokenAddress);
    }

    // mapping(uint => mapping(address => bool)) private hasVoted;

    // event PostCreated(uint postID);
    // event Voted(uint postID, address voter, bool isUpvote);
    // event VotingEnded(uint postID, uint upvotes, uint downvotes);

    // function createPost(
    //     string memory itemType,
    //     uint endTime,
    //     uint price
    // ) public {
    //     require(endTime > block.timestamp, "End time should be in the future");
    //     uint postID = postList.length;
    //     newPost = Post({
    //         postID: postID,
    //         publisher: msg.sender,
    //         itemType: itemType,
    //         status: "Open",
    //         createdTime: block.timestamp,
    //         endTime: endTime,
    //         price: price,
    //         upvote: 0,
    //         downvote: 0
    //     });
    //     postList.push(newPost);
    //     emit PostCreated(postID);
    // }

    // function vote(uint postID, bool isUpvote) external {
    //     require(postID < postList.length, "Invalid post ID");
    //     Post storage post = postList[postID];
    //     require(post.endTime > block.timestamp, "Voting has ended");
    //     require(!hasVoted[postID][msg.sender], "You've already voted");

    //     if (isUpvote) {
    //         post.upvote++;
    //     } else {
    //         post.downvote++;
    //     }
    //     hasVoted[postID][msg.sender] = true;

    //     emit Voted(postID, msg.sender, isUpvote);
    // }

    // function endVoting(uint postID) public {
    //     require(postID < postList.length, "Invalid post ID");
    //     Post storage post = postList[postID];
    //     require(post.endTime <= block.timestamp, "Voting is still active");
    //     post.status = "Closed";
    //     emit VotingEnded(postID, post.upvote, post.downvote);
    // }
}
