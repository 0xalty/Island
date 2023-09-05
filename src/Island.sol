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
    // requireより、こっちの方がガス代が安い
    error Island__MustBeBetween0to100();
    error Island__PriceMustBePositive();
    error Island__InvalidTokenURI();
    error Island__InvalidPayment();
    error Island__CuratorsNumberOverflown();
    error Island__NoProceeds();
    error Island__TotalShareMustBeLessThan100();
    error Island__TransferFailed();

    enum License {
        MIT,
        CC
    }

    struct Listing {
        uint256 price;
        address seller;
    }

    // nftのデータを一つにまとめた方が、、
    struct NftData {
        string tokenParam;
        address artistAddress;
        address[] curatorsAddress;
        License license;
    }

    // storageを使用していることをs_で明記する
    uint256 private s_tokenId;
    uint256 private x; // x means artist share
    uint256 private y; // y means curators share

    mapping(uint256 => NftData) private s_tokenIdToNftData;
    mapping(uint256 => Listing) private s_tokenIdToListings;
    mapping(address => uint256) private s_proceeds;

    event NftMinted(uint256 indexed tokenId, address indexed artistAddress);
    event NftListed(uint256 indexed tokenId, address indexed seller, uint256 price);
    event NftRegistered(uint256 indexed tokenId, address indexed artistAddress);
    event NftBought(uint256 indexed tokenId, address indexed buyerAddress, uint256 price);

    modifier between0to100(uint256 share) {
        if (share < 0 || share > 100) {
            revert Island__MustBeBetween0to100();
        }
        _;
    }

    modifier totalShareMustBeLessThan100(uint256 _x, uint256 _y) {
        if (_x + _y > 100) {
            revert Island__TotalShareMustBeLessThan100();
        }
        _;
    }

    constructor(uint256 _x) ERC721("OnChainParamNFT", "OCP") between0to100(_x) {
        s_tokenId = 0;
        x = _x;
    }

    //1.Register Artwork by artists
    function registerArtwork(string calldata cid, uint256 price, License license) external {
        _mintNft(cid, license);
        listNft(s_tokenId, price);
        emit NftRegistered(s_tokenId, msg.sender);
    }

    function listNft(uint256 tokenId, uint256 price) public {
        if (price < 0) {
            revert Island__PriceMustBePositive();
        }
        s_tokenIdToListings[tokenId] = Listing(price, msg.sender);
        emit NftListed(tokenId, msg.sender, price);
    }

    //2.Introduce NFT by curators？
    function introduceNFT(uint256 tokenId) public {
        if (!_exists(tokenId)) {
            revert Island__InvalidTokenURI();
        }
        if (s_tokenIdToNftData[tokenId].curatorsAddress.length > 100) {
            revert Island__CuratorsNumberOverflown();
        }

        s_tokenIdToNftData[tokenId].curatorsAddress.push(msg.sender);
    }

    //3.Buy NFT by consumers
    function buyNft(uint256 tokenId) public payable {
        if (s_tokenIdToListings[tokenId].price != msg.value) {
            revert Island__InvalidPayment();
        }

        // 販売者から購入者への直接送金はセキュリティ上良くはない
        // -> 販売時購入者からこのコントラクトへ送金、withdraw関数で販売者が任意のタイミングで引き出す
        // artist_amount = msg.value * x / 100;
        // Address.sendValue(payable(artistsAddress[tokenId]), artist_amount);
        // artistの配分
        uint256 artistAmount = msg.value * x / 100;
        s_proceeds[s_tokenIdToNftData[tokenId].artistAddress] += artistAmount;

        // curatorの配分
        // 毎回ストレージから読み取るとガス代が高いので、変数に格納しておく
        uint256 curatorsTotalAmount = msg.value * y / 100;
        uint256 curatorsAddressSize = s_tokenIdToNftData[tokenId].curatorsAddress.length;
        for (uint256 i = 0; i < curatorsAddressSize; i++) {
            uint256 curatorAmount = curatorsTotalAmount / curatorsAddressSize;
            s_proceeds[s_tokenIdToListings[tokenId].seller] += curatorAmount;
        }

        // sellerの配分
        uint256 seller_amount = msg.value - artistAmount - curatorsTotalAmount;
        s_proceeds[s_tokenIdToListings[tokenId].seller] += seller_amount;

        emit NftBought(tokenId, msg.sender, msg.value);
    }

    function setX(uint256 _x) external onlyOwner totalShareMustBeLessThan100(_x, y) {
        x = _x;
    }

    function setY(uint256 _y) external onlyOwner totalShareMustBeLessThan100(x, _y) {
        y = _y;
    }

    //4.Response metadata for market place
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        if (!_exists(tokenId)) {
            revert Island__InvalidTokenURI();
        }

        string memory tokenParam = s_tokenIdToNftData[tokenId].tokenParam;
        return string(
            abi.encodePacked(
                "{" '"name": "Islands token", ' '"description": "This is Islands nft", '
                '"image": "https://copper-shy-parrotfish-397.mypinata.cloud/ipfs/',
                tokenParam,
                '"' "}"
            )
        );
    }

    // CEIに従う
    function withdrawProceeds() external {
        // Check
        uint256 proceeds = s_proceeds[msg.sender];
        if (proceeds <= 0) {
            revert Island__NoProceeds();
        }
        // Effect
        s_proceeds[msg.sender] = 0;
        // Interaction
        // callを使ったほうがガス代が安い
        (bool success,) = payable(msg.sender).call{value: proceeds}("");
        if (!success) {
            revert Island__TransferFailed();
        }
    }

    function _mintNft(string calldata cid, License license) private {
        s_tokenId++;
        _safeMint(msg.sender, s_tokenId);
        s_tokenIdToNftData[s_tokenId].tokenParam = cid;
        s_tokenIdToNftData[s_tokenId].artistAddress = msg.sender;
        s_tokenIdToNftData[s_tokenId].license = license;
        emit NftMinted(s_tokenId, msg.sender);
    }
}
