// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721{
  mapping(uint256 => address) private _tokenOwner;
  mapping(address => uint256) private _ownedTokensCount;

  event Tranfer(address indexed from,address indexed to,uint256 indexed tokenId);

  modifier addressNotZero (address checkAdd){
    require(checkAdd != address(0));
    _;
  }
  modifier tokenHasNotMint(uint256 tokenId){
    require(_tokenOwner[tokenId] == address(0));
    _;
  }
  function _mint(address to, uint256 tokenId) internal addressNotZero(to) tokenHasNotMint(tokenId){
    _tokenOwner[tokenId] = to;
    _ownedTokensCount[to] ++;
    emit Tranfer(address(0), to, tokenId);
  }

}