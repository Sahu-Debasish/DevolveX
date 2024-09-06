// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DAOLegalArbitration {

    struct Dispute {
        string description;
        address claimant;
        address respondent;
        uint votesForClaimant;
        uint votesForRespondent;
        uint endTime;
        bool resolved;
    }

    mapping(address => uint) public governanceTokenBalance;
    Dispute[] public disputes;
    mapping(uint => mapping(address => bool)) public voted;

    uint public arbitrationDuration;

    constructor(uint _arbitrationDuration) {
        arbitrationDuration = _arbitrationDuration;
    }

    modifier onlyTokenHolder() {
        require(governanceTokenBalance[msg.sender] > 0, "You must hold governance tokens to participate.");
        _;
    }

    function createDispute(string memory _description, address _respondent) public onlyTokenHolder {
        disputes.push(Dispute({
            description: _description,
            claimant: msg.sender,
            respondent: _respondent,
            votesForClaimant: 0,
            votesForRespondent: 0,
            endTime: block.timestamp + arbitrationDuration,
            resolved: false
        }));
    }

    function voteOnDispute(uint _disputeId, bool supportClaimant) public onlyTokenHolder {
        Dispute storage dispute = disputes[_disputeId];
        require(block.timestamp < dispute.endTime, "Arbitration period has ended.");
        require(!voted[_disputeId][msg.sender], "Already voted.");

        uint voteWeight = governanceTokenBalance[msg.sender];

        if (supportClaimant) {
            dispute.votesForClaimant += voteWeight;
        } else {
            dispute.votesForRespondent += voteWeight;
        }

        voted[_disputeId][msg.sender] = true;
    }

    function resolveDispute(uint _disputeId) public {
        Dispute storage dispute = disputes[_disputeId];
        require(block.timestamp >= dispute.endTime, "Arbitration period has not ended.");
        require(!dispute.resolved, "Dispute already resolved.");

        if (dispute.votesForClaimant > dispute.votesForRespondent) {
            // Claimant wins
        } else {
            // Respondent wins
        }

        dispute.resolved = true;
    }

    function depositTokens() public payable {
        governanceTokenBalance[msg.sender] += msg.value;
    }

    receive() external payable {}
}
