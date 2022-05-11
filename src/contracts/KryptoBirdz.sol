// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './ERC721Connector.sol';

contract KryptoBirdz is ERC721Connector{

  string[] public kryptoBirdz;

  mapping(string => bool) _kryptoBirdzExists;

  function mint(string memory _kryptoBirdz) public{
    require(!_kryptoBirdzExists[_kryptoBirdz],
    'Error - KryptoBirdz already exists');

    kryptoBirdz.push(_kryptoBirdz);
    uint _id = kryptoBirdz.length -1;

    _mint(msg.sender, _id);
    
    _kryptoBirdzExists[_kryptoBirdz] = true;
  }

  constructor() ERC721Connector('KryptoBirdz','KBIRDZ'){
    
  }
}