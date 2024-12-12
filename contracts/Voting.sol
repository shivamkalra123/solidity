// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(string => uint256) public votesReceived;
    string[] public candidateList;

    constructor(string[] memory candidateNames) {
        candidateList = candidateNames;
    }

    function voteForCandidate(string memory candidate) public {
        require(candidateExists(candidate), "Candidate does not exist.");
        votesReceived[candidate]++;
    }

    function totalVotesFor(string memory candidate) public view returns (uint256) {
        require(candidateExists(candidate), "Candidate does not exist.");
        return votesReceived[candidate];
    }

    function candidateExists(string memory candidate) public view returns (bool) {
        for (uint i = 0; i < candidateList.length; i++) {
            if (keccak256(abi.encodePacked(candidate)) == keccak256(abi.encodePacked(candidateList[i]))) {
                return true;
            }
        }
        return false;
    }
}
