// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Openzeppelin contracts
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YakToken is Ownable, ERC20, ReentrancyGuard {
    constructor(uint256 initialSupply) ERC20("Yak", "YAK") {}
}
