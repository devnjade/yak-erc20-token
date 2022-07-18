// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Openzeppelin contracts
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YakToken is Ownable, ERC20, ReentrancyGuard {
    uint256 public totalTokenSupply;
    uint256 public claimAmount;
    uint256 public totalAddressesAllowed;

    bool public enableClaim;

    mapping(address => bool) addresses;
    mapping(address => uint256) amountOfClaims;

    constructor() ERC20("Yak", "YAK") {
        totalAddressesAllowed = 0;
        claimAmount = 0;
    }

    function totalClaimed() public view returns (uint256) {
        return totalTokenSupply;
    }

    function totalTimesAddrClaimed(address addr) public view returns (uint256) {
        return amountOfClaims[addr];
    }

    function setClaiming(bool enable) public {
        enableClaim = enable;
    }

    function mint(address to) public nonReentrant {
        require(verifyAddress(to), "Address not allowed to claim token");
        require(amountOfClaims[to] == 0, "Address already claimed");

        _mint(to, claimAmount);
        amountOfClaims[to]--;
        totalTokenSupply += claimAmount;
    }

    function updateClaimAmount(uint256 amount) public onlyOwner {
        claimAmount = amount;
    }

    function addClaimAddress(address addr, uint256 claim) public onlyOwner {
        require(!addresses[addr], "Address already added");
        addresses[addr] = true;
        amountOfClaims[addr] = claim;
        totalAddressesAllowed++;
    }

    function addClaimAddresses(address[] memory addr, uint256 claim)
        public
        onlyOwner
    {
        for (uint256 i = 0; i < addr.length; i++) {
            addClaimAddress(addr[i], claim);
        }
    }

    function removeClaimAddress(address addr) public onlyOwner {
        require(addresses[addr], "Address not added");
        addresses[addr] = false;
        amountOfClaims[addr] = 0;
        totalAddressesAllowed--;
    }

    function removeClaimAddresses(address[] memory addr) public onlyOwner {
        for (uint256 i = 0; i < addr.length; i++) {
            removeClaimAddress(addr[i]);
        }
    }

    function verifyAddress(address addr) public view returns (bool) {
        return addresses[addr];
    }

    function checkAmountOfClaims(address addr) public view returns (uint256) {
        return amountOfClaims[addr];
    }
}
