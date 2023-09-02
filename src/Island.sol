// Layout of Contract:
// version
// imports
// interfaces, libraries, contracts
// errors
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Island is ERC721, Ownable {
    error Island__MustBeBetween0to100(uint256 share);

    enum License {
        MIT,
        CC
    }

    struct Listing {
        uint256 price;
        uint256 seller;
    }

    struct NftInfo {
        string tokenParam;
        address artistAddress;
        
    }

    uint256 private s_tokenId;
    uint256 private s_price;
    uint256 private s_artistShare;

    mapping(uint256 => string) private s_tokenIdTotokenParameters;
    mapping(uint256 => address) private artistsAddress;
    mapping(uint256 => address[100]) private curatorsAddress;
    mapping(uint256 => string) private s_tokenIdToLisence;
    mapping(uint256 => Listing) private s_TokenIdToListings;

    modifier between0to100(uint256 share) {
        if (share < 0 || share > 100) {
            revert Island__MustBeBetween0to100(share);
        }
        _;
    }

    constructor(uint256 artistShare) ERC721("OnChainParamNFT", "OCP") between0to100(artistShare) {
        s_tokenId = 0;
        s_artistShare = artistShare;
    }

    //1.Register Artwork by artists
    function registerArtwork(string calldata cid, uint256 price, uint256 license) public {
        s_tokenId++;
        s_tokenParameters[s_tokenId] = cid;
        artistsAddress[s_tokenId] = msg.sender;

        s_price = price;

        _safemint(msg.sender, s_tokenId);

        s_lisence[s_tokenId] = licenses[license];
    }

    //2.Introduce NFT by curators？
    function introduceNFT(uint256 tokenId) public {
        require(_exists(tokenId));
        curatorsAddress[tokenId][curatorsAddressSize] = msg.sender;
        curatorsAddressSize++;
    }

    //3.Buy NFT by consumers
    function newListing(uint256 tokenId) public payable {
        require(s_price == msg.value);

        address introducedAddress;
        uint256 artist_amount;
        uint256 curators_amount;

        artist_amount = msg.value * artistShare / 100;
        Address.sendValue(payable(artistsAddress[tokenId]), artist_amount);

        for (uint256 i = 0; i < curatorsAddressSize; i++) {
            introducedAddress = curatorsAddress[tokenId][i];

            curators_amount = (msg.value - artist_amount) / curatorsAddressSize;
            Address.sendValue(payable(curatorsAddress[tokenId][i]), curators_amount);
        }
    }

    function setArtistShare(uint256 newArtistShare) public onlyOwner {
        s_artistShare = newArtistShare;
    }

    //4.Response metadata for market place
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ilands: URI query for nonexistent token");

        string memory tokenParameter = s_tokenParameters[tokenId];
        return string(
            abi.encodePacked(
                "{" '"name": "Islands token", ' '"description": "This is Islands nft", '
                '"image": "https://copper-shy-parrotfish-397.mypinata.cloud/ipfs/',
                tokenParameter,
                '"' "}"
            )
        );
    }
}
