// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

error Ropstam__Insufficient_Funds_Provided();
error Ropstam__Not_Enough_Tokens();

contract Ropstam is ERC20, Ownable {
    uint256 private immutable i_price;
    uint256 private remaining_supply;
   
    constructor(uint256 _tokenPrice, uint256 _maxSupply) ERC20("Ropstam", "RPM") {
        i_price=_tokenPrice;
        remaining_supply=_maxSupply;
    }

    function buyRopstam() public payable {
        if(msg.value==0){
            revert Ropstam__Insufficient_Funds_Provided();
        }
        uint256 recevingTokens = (msg.value *(10**18)) / i_price; 
        if(remaining_supply<recevingTokens) {
            revert Ropstam__Not_Enough_Tokens();
        }
        remaining_supply = remaining_supply-recevingTokens;
        _mint(msg.sender,recevingTokens);
    }

     // Override the ERC20 transfer function
    function transfer(address to, uint256 amount) public override returns (bool) {
        uint256 burnAmount = (amount * 5) / 100;
        uint256 transferAmount = amount - burnAmount;
        _burn(msg.sender, burnAmount);
        super.transfer(to, transferAmount);
        return true;
    }

    // Override the ERC20 transferFrom function
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        uint256 burnAmount = (amount * 5) / 100; //Burn 5% amount of tokens 
        uint256 transferAmount = amount - burnAmount;
        _burn(from, burnAmount);
        super.transferFrom(from, to, transferAmount);
        return true;
    }

    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance>0,"Nothing to withdraw");
        (bool success,) = (msg.sender).call{value:balance}("");
        require(success,"Transfer Failed");
    }

   function getPrice() public view returns(uint256){
        return i_price;
   }

   function getRemainingSupply() public view returns(uint256){
        return remaining_supply;
   }

}