// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC165.sol";
import "./interfaces/IERC721.sol";

contract ERC721 is ERC165,IERC721 {
  mapping(uint256 => address) private _tokenOwner;
  mapping(address => uint256) private _ownedTokensCount;

  // event Tranfer(address indexed from,address indexed to,uint256 indexed tokenId);
  constructor (){
    registerInterface(bytes4(keccak256('balanceOf(address)') ^
                              keccak256('ownerOf(uint256)') ^
                              keccak256('transferFrom(address)') ));
  }

  modifier addressNotZero (address checkAdd){
    require(checkAdd != address(0),
    'Error Address is zero');
    _;
  }
  modifier tokenHasNotMint(uint256 tokenId){
    require(_tokenOwner[tokenId] == address(0),
    'Error This token has already mint');
    _;
  }
  function _mint(address to, uint256 tokenId) internal virtual addressNotZero(to) tokenHasNotMint(tokenId){
    _tokenOwner[tokenId] = to;
    _ownedTokensCount[to] += 1;
    emit Transfer(address(0), to, tokenId);
  }

  function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
    require(_to != address(0), 'To address not exist');
    require(ownerOf(_tokenId) == _from,'from address not own this token');
    _tokenOwner[_tokenId] = _to;
    _ownedTokensCount[_to] += 1;
    _ownedTokensCount[_from] -= 1;
  }

  function balanceOf(address _owner) public view addressNotZero(_owner) returns (uint256){
    uint256 _balance = _ownedTokensCount[_owner];
    return _balance;
  }
  function ownerOf(uint256 _tokenId) public view returns (address){
    address _owner = _tokenOwner[_tokenId];
    require(_owner != address(0),'Owner of this token is not exist');
    return _owner;
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    _transferFrom(_from, _to, _tokenId);
  }
}