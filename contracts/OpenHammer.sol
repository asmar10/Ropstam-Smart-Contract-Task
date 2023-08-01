// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "hardhat/console.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
}

error OpenHammer__You_Own_OpenApes();
error OpenHammer__You_Own_Hammer();
error OpenHammer__Insufficent_Ropstam_Tokens();
error OpenHammer__Nothing_to_Withdraw();
error OpenHammer__Address_Already_Exists(address _address);
error OpenHammer__Invalid_Address();

contract OpenHammer is ERC1155 {
    using Strings for uint256;  

    /*events*/
    event Owner_Added(address indexed owner);

    /*Modifiers*/
    modifier onlyOwner {
        require(isOwner[msg.sender],"Caller is not the Owner");
        _;
    }

    /*State Variables*/
    mapping(address=>bool) private isOwner;
    uint256 public constant HAMMER = 0;
    uint256 public constant OPEN_APES = 1;
    uint256 private immutable i_Price;
    IERC20 private immutable i_Ropstam;
    string private _uri;

    constructor(uint256 _price, address ropstamTokenAddress, string memory _baseURI, address[] memory owners) ERC1155(_baseURI) {    
        i_Price=_price;
        i_Ropstam = IERC20(ropstamTokenAddress);
        _uri = _baseURI;
        isOwner[msg.sender]=true;
        addOwners(owners);
    }

    function buyHammer(uint256 _ropstamTokens) public {
        if(balanceOf(msg.sender,OPEN_APES)!=0){
            revert OpenHammer__You_Own_OpenApes();
        }

        if(i_Ropstam.balanceOf(msg.sender)<_ropstamTokens){
            revert OpenHammer__Insufficent_Ropstam_Tokens();
        }
        uint256 recevingHammer = (_ropstamTokens*(10**18)) / i_Price; 

        i_Ropstam.transferFrom(msg.sender,address(this),_ropstamTokens);
        _mint(msg.sender, HAMMER, recevingHammer, "");
    }
    
    function buyOpenApes(uint256 _amount) public {
        if(balanceOf(msg.sender,HAMMER)!=0){
            revert OpenHammer__You_Own_Hammer();
        }
        uint256 cost = _amount*i_Price;

        if(i_Ropstam.balanceOf(msg.sender)<cost){
            revert OpenHammer__Insufficent_Ropstam_Tokens();
        }

        i_Ropstam.transferFrom(msg.sender,address(this),cost);
        _mint(msg.sender, OPEN_APES, _amount, "");
    }

    function withDraw() external onlyOwner{
        uint256 balance = i_Ropstam.balanceOf(address(this));

        if(balance==0){
            revert OpenHammer__Nothing_to_Withdraw();
        }
        i_Ropstam.transfer(msg.sender,balance);
    }

    function addOwners(address[] memory owners) public onlyOwner {
        for(uint256 i; i<owners.length; ++i){
            if(owners[i]==address(0)){
                revert OpenHammer__Invalid_Address();
            }
            if(isOwner[owners[i]]){
                revert OpenHammer__Address_Already_Exists(owners[i]);
            }
            isOwner[owners[i]]=true;
            emit Owner_Added(owners[i]);
        }
    }

    function uri(uint256 _tokenid) override public view returns (string memory tokenUri) {
        require(_tokenid < 2,"Invalid Token ID");
        tokenUri = string(abi.encodePacked(_uri, _tokenid.toString(), ".json"));
    }

    function getPrice() public view returns(uint256){
        return i_Price;
    }

}