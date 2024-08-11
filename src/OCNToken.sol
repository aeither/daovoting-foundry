// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract OCNToken is ERC20 {
    constructor() ERC20("OCN Token", "OCN") {}

    function mint(uint256 amount) public {
        _mint(msg.sender, amount);
    }
}
