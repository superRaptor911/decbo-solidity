pragma solidity ^0.8.3;

contract Voting {
    struct Voter {
        address id;
        bool voted;
    }

    struct Candidate {
        address id;
        uint votes;
    }

    mapping(address => Voter) voters;
    mapping(address => Candidate) candidates;

    address[] candidateList;
    address[] voterList;

    event Voted(address voter);
    event CandidateJoined(address candidate);

    address public ceo;

    constructor() {
        ceo = msg.sender;
    }

    function addVoters(address[] memory _voters) external {
        require(ceo == msg.sender, "Not chief ellection officer");
        for (uint i = 0; i < _voters.length; i++) {
            voters[_voters[i]] = Voter({id: _voters[i], voted: false});
            voterList.push(_voters[i]);
        }
    }

    function addCandidates(address[] memory _candidates) external {
        require(ceo == msg.sender, "Not chief ellection officer");
        for (uint i = 0; i < _candidates.length; i++) {
            candidates[_candidates[i]] = Candidate({id: _candidates[i], votes: 0});
            candidateList.push(_candidates[i]);
            emit CandidateJoined(_candidates[i]);
        }
    }

    function getVoters() external view returns (address[] memory) {
        return voterList;
    }

    function getCandidates() external view returns (address[] memory) {
        return candidateList;
    }


    function vote(address _candidate) external {
        require(voters[msg.sender].id == msg.sender, "Not in voters list");
        require(voters[msg.sender].voted == false, "Already Voted");
        require(candidates[_candidate].id == _candidate, "Invalid Candidate");

        candidates[_candidate].votes++;
        voters[msg.sender].voted = true;
        emit Voted(msg.sender);
    }

    function getWinner() external view returns (address) {
        uint maxVotes = 0;
        uint winner = 0;
        for (uint i = 0; i < candidateList.length; i++) {
            uint votes = candidates[candidateList[i]].votes ;
            if (votes> maxVotes) {
                maxVotes = votes;
                winner = i;
            }
        }

        return candidateList[winner];
    }
}
