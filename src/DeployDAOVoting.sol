// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract DAOVoting {
    struct Proposal {
        string description;
        uint256 voteCount;
        uint256 endTime;
        bool executed;
    }

    address public owner;
    mapping(address => bool) public members;
    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    uint256 public proposalCount;

    event ProposalCreated(uint256 proposalId, string description, uint256 endTime);
    event Voted(uint256 proposalId, address voter);
    event ProposalExecuted(uint256 proposalId);

    constructor() {
        owner = msg.sender;
        members[msg.sender] = true;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlyMember() {
        require(members[msg.sender], "Only members can call this function");
        _;
    }

    function addMember(address _member) public onlyOwner {
        members[_member] = true;
    }

    function removeMember(address _member) public onlyOwner {
        members[_member] = false;
    }

    function createProposal(string memory _description, uint256 _votingPeriod) public onlyMember {
        proposalCount++;
        proposals[proposalCount] = Proposal({
            description: _description,
            voteCount: 0,
            endTime: block.timestamp + _votingPeriod,
            executed: false
        });

        emit ProposalCreated(proposalCount, _description, block.timestamp + _votingPeriod);
    }

    function vote(uint256 _proposalId) public onlyMember {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp < proposal.endTime, "Voting period has ended");
        require(!hasVoted[_proposalId][msg.sender], "You have already voted on this proposal");

        proposal.voteCount++;
        hasVoted[_proposalId][msg.sender] = true;

        emit Voted(_proposalId, msg.sender);
    }

    function executeProposal(uint256 _proposalId) public onlyMember {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp >= proposal.endTime, "Voting period has not ended yet");
        require(!proposal.executed, "Proposal has already been executed");

        proposal.executed = true;

        // Here you would typically implement the logic to execute the proposal
        // For this example, we'll just emit an event
        emit ProposalExecuted(_proposalId);
    }

    function getProposal(uint256 _proposalId)
        public
        view
        returns (string memory description, uint256 voteCount, uint256 endTime, bool executed)
    {
        Proposal storage proposal = proposals[_proposalId];
        return (proposal.description, proposal.voteCount, proposal.endTime, proposal.executed);
    }
}
