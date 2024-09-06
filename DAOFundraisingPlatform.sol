// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DAOFundraisingPlatform {

    struct Proposal {
        string description;
        address recipient;
        uint amount;
        uint votesFor;
        uint votesAgainst;
        bool executed;
        uint endTime;
    }

    mapping(address => uint) public governanceTokenBalance;
    Proposal[] public proposals;
    address public owner;
    uint public minimumQuorum;
    uint public votingDuration;

    constructor(uint _minimumQuorum, uint _votingDuration) {
        owner = msg.sender;
        minimumQuorum = _minimumQuorum;
        votingDuration = _votingDuration;
    }

    modifier onlyTokenHolder() {
        require(governanceTokenBalance[msg.sender] > 0, "You must hold governance tokens to participate.");
        _;
    }

    function createProposal(string memory _description, address _recipient, uint _amount) public onlyTokenHolder {
        proposals.push(Proposal({
            description: _description,
            recipient: _recipient,
            amount: _amount,
            votesFor: 0,
            votesAgainst: 0,
            executed: false,
            endTime: block.timestamp + votingDuration
        }));
    }

    function vote(uint _proposalId, bool support) public onlyTokenHolder {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp < proposal.endTime, "Voting period has ended.");
        require(!proposal.executed, "Proposal already executed.");

        uint voteWeight = governanceTokenBalance[msg.sender];

        if (support) {
            proposal.votesFor += voteWeight;
        } else {
            proposal.votesAgainst += voteWeight;
        }
    }

    function executeProposal(uint _proposalId) public {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp >= proposal.endTime, "Voting period has not ended.");
        require(!proposal.executed, "Proposal already executed.");
        require(proposal.votesFor + proposal.votesAgainst >= minimumQuorum, "Minimum quorum not reached.");

        if (proposal.votesFor > proposal.votesAgainst) {
            require(address(this).balance >= proposal.amount, "Not enough funds.");
            payable(proposal.recipient).transfer(proposal.amount);
        }

        proposal.executed = true;
    }

    function depositTokens() public payable {
        governanceTokenBalance[msg.sender] += msg.value;
    }

    receive() external payable {}
}
