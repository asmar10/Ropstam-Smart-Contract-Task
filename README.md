# Ropstam Token Contract

## Contract Addresses
Ropstam Contract: https://sepolia.etherscan.io/address/0x182340113965819948258b013432000eE882853D#code
Openhammer Contract: https://sepolia.etherscan.io/address/0xFd333ce0C3EcD4cc73C03FdAAeFB2cAC0c441510#code

Video Walkthrough Ropstam Token Contract: https://www.loom.com/share/9de69d58576d44abb7c607dde84a541c?sid=f4627ec7-03ec-4053-8736-e9c472a874e1

Video Walkthrough Openhammer: 
Part 1: https://www.loom.com/share/11abe073c81d461f891d5c4fe32f0e81?sid=aacee411-d6b8-4b87-9e16-a9763b982875
Part 2: https://www.loom.com/share/2fd888218bef4c749ecfef98bc4ab2b1?sid=635473df-ab5e-41ff-87fa-bd9f922e9d80


This is the smart contract for the Ropstam Token (RPM), an ERC-20 compliant token deployed on Sepolia testnet.

## Features

- Token Sale: Users can purchase 1 Ropstam token by sending 100 wei to the contract.
- Burn Mechanism: A 5% burn rate is applied to every token transfer, meaning that 5% of the transferred amount is burned (destroyed) from the total supply making it a deflationary token. This encourages long term holding of the token.
- Withdrawal of Funds: The contract owner can withdraw the Ether (ETH) balance from the contract.

## Deployment Details

- **Token Name:** Ropstam
- **Symbol:** RPM
- **Token Price:** 100 wei
- **Maximum Supply:** Max Supply of 1000 Tokens is passed in the constructor

# OpenHammer Contract Details

## Contract Addresses


The OpenHammer contract is an ERC-1155 compliant smart contract on the Sepolia Testnet. It allows users to purchase and own two types of Tokens, a Non-Fungible Token represented as Open Apes and a fungible token represented as Hammer.

## Features

- **ERC-1155 Compliance**: The OpenHammer contract conforms to the ERC-1155 standard, enabling it to manage multiple token types within a single contract.
- **Buying Tokens**: Users can purchase Hammer token or an Open Apes by providing 100 Ropstam tokens.
- **Limitation**: Users who own a Hammer token can not buy Open Apes and vice versa.
- **Withdraw Ropstam Tokens**: Contract owners can withdraw Ropstam tokens from the contract.
- **Multiple Owners Can be added**: Existing owners can add more owners.
- **URI Functionality**: The contract implements a custom URI function to generate token metadata URIs based on token IDs.

## Token URI
s
The URI function in the contract generates metadata URIs for the Hammer and Open Apes tokens. Each token's metadata can be accessed using its respective token ID appended to the base URI.

- **Hammer Token URI**: `https://ipfs.io/ipfs/QmUPabH2yncKtRX536tVMd14VEo4RpUF15ATsVw8n3ryH1/0.json`
- **Open Apes Token URI**: `https://ipfs.io/ipfs/QmUPabH2yncKtRX536tVMd14VEo4RpUF15ATsVw8n3ryH1/1.json`
