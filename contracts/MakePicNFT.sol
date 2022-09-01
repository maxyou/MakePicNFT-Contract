// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MakePicNFT is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  event NFTMintInfo(address sender, uint256 tokenId, string jsonUri);

  constructor() ERC721 ("MakePicNFT", "Make Pic NFT") {
    console.log("Make my picture NFT. Woah!");
  }

  function makePicNFT(string memory jsonUri) public {

    uint256 newItemId = _tokenIds.current();    
    
    _safeMint(msg.sender, newItemId);
    
    _setTokenURI(newItemId, jsonUri);
  
    _tokenIds.increment();

    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    emit NFTMintInfo(msg.sender, newItemId, jsonUri);
  }
}