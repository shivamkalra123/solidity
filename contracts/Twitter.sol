// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Twitter {
    uint16 public MAX_TWEET_LENGTH = 220;

    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;
    address public owner;
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Hey, You are not the Owner");
        _;
    }

    function changeTweetLenght(uint16 newTweetLength) public onlyOwner {
        MAX_TWEET_LENGTH = newTweetLength;
    }

    function createTweet(string memory _tweetContent) public {
        require(
            bytes(_tweetContent).length <= MAX_TWEET_LENGTH,
            "Tweet is tooooo long brother!"
        );
        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweetContent,
            timestamp: block.timestamp,
            likes: 0
        });
        tweets[msg.sender].push(newTweet);
    }
    function likeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id, "Tweet doesnt exists");
        tweets[author][id].likes++;
    }
    function unlikeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id, "Tweet doesnt exists");
        require(tweets[author][id].likes > 0, "Tweet has no likes");
        tweets[author][id].likes--;
    }

    function getTweet(
        address _owner,
        uint256 _index
    ) public view returns (address, string memory, uint256, uint256) {
        Tweet memory tweet = tweets[_owner][_index];
        return (tweet.author, tweet.content, tweet.timestamp, tweet.likes);
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
}
