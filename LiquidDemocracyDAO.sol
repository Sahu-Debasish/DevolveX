// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LiquidDemocracy {

    struct Proposal {
        string description;
        uint votesFor;
        uint votesAgainst;
        bool executed;
        uint endTime;
    }

    mapping(address => address) public delegate;
    mapping(address => uint) public governanceTokenBalance;
    mapping(uint => mapping(address => bool)) public voted;
    Proposal[] public proposals;
    uint public votingDuration;

    constructor(uint _votingDuration) {
        votingDuration = _votingDuration;
    }

    modifier onlyTokenHolder() {
        require(governanceTokenBalance[msg.sender] > 0, "You must hold governance tokens to participate.");
        _;
    }

    function delegateVote(address _to) public onlyTokenHolder {
        require(_to != msg.sender, "Cannot delegate to yourself.");
        delegate[msg.sender] = _to;
    }

    function revokeDelegation() public onlyTokenHolder {
        delegate[msg.sender] = address(0);
    }

    function createProposal(string memory _description) public onlyTokenHolder {
        proposals.push(Proposal({
            description: _description,
            votesFor: 0,
            votesAgainst: 0,
            executed: false,
            endTime: block.timestamp + votingDuration
        }));
    }

    function vote(uint _proposalId, bool support) public onlyTokenHolder {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp < proposal.endTime, "Voting period has ended.");
        require(!voted[_proposalId][msg.sender], "Already voted.");
        
        address voter = delegate[msg.sender] != address(0) ? delegate[msg.sender] : msg.sender;

        uint voteWeight = governanceTokenBalance[voter];

        if (support) {
            proposal.votesFor += voteWeight;
        } else {
            proposal.votesAgainst += voteWeight;
        }

        voted[_proposalId][msg.sender] = true;
    }

    function executeProposal(uint _proposalId) public {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp >= proposal.endTime, "Voting period has not ended.");
        require(!proposal.executed, "Proposal already executed.");

        if (proposal.votesFor > proposal.votesAgainst) {
            // Proposal passed logic
        }

        proposal.executed = true;
    }

    function depositTokens() public payable {
        governanceTokenBalance[msg.sender] += msg.value;
    }

    receive() external payable {}
}
