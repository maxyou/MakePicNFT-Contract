// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";


contract MyBlessNFT is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  // event NFTbless(address sender, string bless);
  // event NFTMark(address sender, string mark);
  // event NFTId(address sender, uint256 tokenId);
  event NFTMintInfo(address sender, uint256 tokenId, string bless);

  constructor() ERC721 ("Bless NFT", "BlessNFT") {
    console.log("This is my bless NFT contract. Woah!");
  }

  // function getTokenId() public view returns (uint tokenId) {
  //     tokenId = _tokenIds.current();      
  // }

  function makeBlessNFT(string memory jsonUri) public {

    uint256 newItemId = _tokenIds.current();    
    
    _safeMint(msg.sender, newItemId);
    
    // Update your URI!!!
    _setTokenURI(newItemId, jsonUri);
  
    _tokenIds.increment();
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    //emit NFTId(msg.sender, newItemId);
    emit NFTMintInfo(msg.sender, newItemId, jsonUri);
  }
}