// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721.sol";
import "./interfaces/IERC721Enumerable.sol";

contract ERC721Enumerable is ERC721,IERC721Enumerable {
  uint256[] private _allTokens;
// map tokenId to index in _allTokens
  mapping (uint256 => uint256) private _allTokenIndexs;
  // map owner address to token id list
  mapping (address => uint256[]) private _ownedTokens;
  // map token id to index in owner token id list
  mapping (uint256 => uint256) private _ownedTokensIndex;


  function totalSupply() override public view returns (uint256){
    return _allTokens.length;
  }

  function tokenByIndex(uint256 _index) override external view returns (uint256){
    require(_index < totalSupply(),"The index is out of bounds");
    return _allTokens[_index];
  }

  function tokenOfOwnerByIndex(address _owner, uint256 _index) override external view returns (uint256){
    require(_index < _ownedTokens[_owner].length,'owner index is out of bounds');
    return _ownedTokens[_owner][_index];
  }

  function _mint(address to, uint256 tokenId) internal override(ERC721) {
    super._mint(to,tokenId);
    _addTokenToAllTokenEnumeration(tokenId);
    _addTokenToAllOwnerEnumeration(to,tokenId);
  }

  function _addTokenToAllTokenEnumeration(uint256 tokenId) private {
    _allTokenIndexs[tokenId] = _allTokens.length;
    _allTokens.push(tokenId);
  }
  function _addTokenToAllOwnerEnumeration(address to, uint256 tokenId) private {
    _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
    _ownedTokens[to].push(tokenId);
  }
}