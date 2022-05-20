// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IERC165.sol";

contract ERC165 is IERC165{
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor (){
      registerInterface(bytes4(keccak256('supportsInterface(bytes4)')));
    }

    function supportsInterface(bytes4 interfaceID) override external view returns (bool){
        return _supportedInterfaces[interfaceID];
    }

    function registerInterface(bytes4 interfaceID) public {
        require(interfaceID != 0xffffffff, 'ERC165 invalid interface');
        _supportedInterfaces[interfaceID] = true;
    }
}