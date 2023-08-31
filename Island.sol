// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract Island is ERC721 {
    string[] licenses = [ "mit", "cc" ];
    
    address owner;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    uint NFTprice;
    uint x = 70;

    using Strings for uint256;

    mapping(uint256 => string) public tokenParameters;
    mapping(uint256 => address) public artistsAddress;
    mapping(uint256 => address[100]) public curatorsAddress;
    mapping(uint256 => string) public NFTlisence;

    uint public curatorsAddressSize = 0;

    constructor() ERC721("OnChainParamNFT", "OCP") {
        owner = msg.sender;
    }

    //1.Register Artwork by artists
    function registerArtwork(string calldata cid, uint price, uint256 license) public returns(uint256) {

        _tokenIds.increment();
        uint256 tokenId = _tokenIds.current();
        tokenParameters[tokenId] = cid;
        artistsAddress[tokenId] = msg.sender;

        NFTprice = price;

        _mint(msg.sender, tokenId);

        NFTlisence[tokenId] = licenses[license];

        return tokenId;
    }

    //2.Introduce NFT by curators
    function introduceNFT(uint256 tokenId) public {
        require(_exists(tokenId));
        curatorsAddress[tokenId][curatorsAddressSize] = msg.sender;
        curatorsAddressSize++;
    }

    //3.Buy NFT by consumers
    function buyNFT(uint256 tokenId) public payable {
        require(NFTprice == msg.value);

        address introducedAddress;
        uint256 artist_amount;
        uint256 curators_amount;

        artist_amount = msg.value * x / 100;
        Address.sendValue(payable (artistsAddress[tokenId]) , artist_amount);

        for (uint i = 0; i < curatorsAddressSize; i++){
            introducedAddress = curatorsAddress[tokenId][i];

            curators_amount = (msg.value - artist_amount) / curatorsAddressSize;
            Address.sendValue(payable (curatorsAddress[tokenId][i]) , curators_amount);
        }

    }

    function setX(uint256 _x) public {
        x = _x;
    }

    //4.Response metadata for market place
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ilands: URI query for nonexistent token");

        string memory tokenParameter = tokenParameters[tokenId];
        return string(abi.encodePacked(
            '{'
                '"name": "Islands token", '
                '"description": "This is Islands nft", '
                '"image": "https://copper-shy-parrotfish-397.mypinata.cloud/ipfs/',
                tokenParameter, 
                '"'
            '}'
            )
        );
    }
    
}