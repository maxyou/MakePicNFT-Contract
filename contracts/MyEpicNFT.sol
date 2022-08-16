// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We need to import the helper functions from the contract that we copy/pasted.
import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  uint NftMaxNum = 100;

  string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

  // event NFTBrand(address sender, string brand);
  // event NFTMark(address sender, string mark);
  // event NFTId(address sender, uint256 tokenId);
  event NFTMintInfo(address sender, uint256 tokenId, string brand, string mark);

  constructor() ERC721 ("SquareNFT", "SQUARE") {
    console.log("This is my NFT contract. Woah!");
  }

  function getTokenId() public view returns (uint tokenId, uint MaxNum) {
      //return _tokenIds.current();
      tokenId = _tokenIds.current();
      MaxNum = NftMaxNum;
  }

  function makeAnEpicNFT(string memory brand) public {

    uint256 newItemId = _tokenIds.current();

    require(newItemId < NftMaxNum, "no more than NftMaxNum" );

    //emit NFTBrand(msg.sender, brand);
    string memory mark = string(abi.encodePacked(Strings.toString(newItemId+1)," of ",  Strings.toString(NftMaxNum), " : ", brand));
    //emit NFTMark(msg.sender, mark);

    string memory finalSvg = string(abi.encodePacked(baseSvg, mark,  "</text></svg>"));
    // string memory finalSvg = string(abi.encodePacked(baseSvg, combinedWord, "-", Strings.toString(newItemId),  "</text></svg>"));

    // Get all the JSON metadata in place and base64 encode it.
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    // We set the title of our NFT as the generated word.
                    Strings.toString(newItemId+1),
                    '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                    // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                    Base64.encode(bytes(finalSvg)),
                    '"}'
                )
            )
        )
    );

    // Just like before, we prepend data:application/json;base64, to our data.
    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

    console.log("\n--------------------");
    console.log(finalTokenUri);
    console.log("--------------------\n");

    _safeMint(msg.sender, newItemId);
    
    // Update your URI!!!
    _setTokenURI(newItemId, finalTokenUri);
  
    _tokenIds.increment();
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    //emit NFTId(msg.sender, newItemId);
    emit NFTMintInfo(msg.sender, newItemId, brand, mark);
  }
}