# DevolveX


### A Decentralized Autonomous Organization (DAO) Platform for Fundraising, Liquid Democracy, and Legal Arbitration.

Welcome to **DevolveX**, a fully decentralized DAO platform that empowers users to manage decentralized fundraising, delegate voting powers in a liquid democracy model, and resolve disputes through a decentralized legal arbitration system. Built on Solidity, the platform utilizes smart contracts for governance and decision-making.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Smart Contracts](#smart-contracts)
  - [DAO Fundraising Platform](#dao-fundraising-platform)
  - [Liquid Democracy DAO](#liquid-democracy-dao)
  - [DAO Legal Arbitration](#dao-legal-arbitration)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

**DevolveX** is designed to be a comprehensive solution for managing decentralized organizations using blockchain technology. The platform aims to decentralize key decision-making processes, allowing DAOs to:
1. Raise funds and collectively vote on investments.
2. Enable liquid democracy, where governance token holders can delegate or revoke voting power.
3. Resolve disputes using decentralized legal arbitration, with outcomes determined by token-weighted votes.

## Features

- **Fundraising Platform:** Allows DAO members to create proposals and vote on where pooled funds should be invested.
- **Liquid Democracy:** Supports voting delegation and flexible governance models, enabling efficient decision-making through trusted representatives.
- **Decentralized Legal Arbitration:** Resolves disputes within or between DAOs, where outcomes are governed by token holders.
- **Governance Tokens:** Token holders' votes are weighted based on their token balances, ensuring fairness in the decision-making process.

## Smart Contracts

### 1. **DAO Fundraising Platform**
The **DAO Fundraising Platform** allows users to propose and vote on investment ideas or donations using the DAO’s collective funds. The funds are managed based on the outcome of the voting process.

- **File:** [`DAOFundraisingPlatform.sol`](./contracts/DAOFundraisingPlatform.sol)
- **Functionality:** Proposal creation, voting, and execution based on governance token balance.

### 2. **Liquid Democracy DAO**
This contract implements the concept of liquid democracy, allowing token holders to delegate their voting power to others while retaining the ability to revoke the delegation at any time.

- **File:** [`LiquidDemocracyDAO.sol`](./contracts/LiquidDemocracyDAO.sol)
- **Functionality:** Voting delegation, revocation, proposal creation, and execution.

### 3. **DAO Legal Arbitration**
The **DAO Legal Arbitration** contract allows for decentralized dispute resolution. DAO members can initiate disputes, and voting will determine the outcome. 

- **File:** [`DAOLegalArbitration.sol`](./contracts/DAOLegalArbitration.sol)
- **Functionality:** Dispute creation, voting, and resolution.

---

## Installation

To get started with **DevolveX**, follow these steps:

### Prerequisites
- **Node.js** and **npm**: You’ll need Node.js and npm installed. Download it from [Node.js official site](https://nodejs.org/).
- **Truffle**: Install Truffle for smart contract deployment.
  ```bash
  npm install -g truffle
  ```
- **Ganache**: A local blockchain for Ethereum development. [Download Ganache](https://www.trufflesuite.com/ganache).

### Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Sahu-Debasish/DevolveX.git
   cd DevolveX
   ```

2. **Install Dependencies**
   ```bash
   npm install
   ```

3. **Compile the Smart Contracts**
   ```bash
   truffle compile
   ```

4. **Deploy the Contracts**
   Set up `truffle-config.js` to connect to your local or test blockchain (e.g., Ganache). Then deploy:
   ```bash
   truffle migrate --network development
   ```

5. **Run Tests**
   Execute the smart contract tests:
   ```bash
   truffle test
   ```

---

## Usage

### Interact with the Contracts

Once the contracts are deployed, you can interact with them through the Truffle console or integrate with a front-end using Web3.js or ethers.js.

1. **Start the Truffle Console**
   ```bash
   truffle console
   ```

2. **Interact with Deployed Contracts**
   Example: Creating a proposal in the DAO Fundraising Platform.
   ```javascript
   const daoFundraising = await DAOFundraisingPlatform.deployed();
   daoFundraising.createProposal("Fund new DeFi protocol", recipientAddress, web3.utils.toWei("10", "ether"));
   ```

### Integrating Front-End (Optional)
You can integrate **DevolveX** smart contracts into a front-end using libraries like **Web3.js** or **ethers.js** to make it more user-friendly.

---

## Contributing

We welcome contributions from the community! Here’s how you can get involved:

1. **Fork the repository**
2. **Create a new branch**
   ```bash
   git checkout -b feature/your-feature
   ```
3. **Make your changes and commit**
   ```bash
   git commit -m "Add new feature"
   ```
4. **Push to your branch**
   ```bash
   git push origin feature/your-feature
   ```
5. **Submit a pull request**

Feel free to open issues for suggestions, bugs, or enhancements.

---

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

---

## Contact

If you have any questions or feedback, feel free to reach out via the [GitHub Issues page](https://github.com/Sahu-Debasish/DevolveX/issues).

---

*Happy Buidling with DevolveX!*

