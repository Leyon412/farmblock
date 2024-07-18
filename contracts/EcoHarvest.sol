// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EcoHarvest is ERC20, Ownable {
    struct Farm {
        string name;
        address owner;
        uint256 carbonCredits;
        string ipfsHash; // Added IPFS hash
    }

    mapping(uint256 => Farm) public farms;
    uint256 public farmCount;

    constructor() ERC20("EcoHarvest", "ECO") {
        _mint(msg.sender, 1000000 * 10**decimals());
    }

    function createFarm(string memory _name, string memory _ipfsHash) public {
        farmCount++;
        farms[farmCount] = Farm(_name, msg.sender, 0, _ipfsHash);
    }

    function addCarbonCredits(uint256 _farmId, uint256 _amount) public {
        require(farms[_farmId].owner == msg.sender, "Not the farm owner");
        farms[_farmId].carbonCredits += _amount;
        _mint(msg.sender, _amount);
    }

    function transferCarbonCredits(uint256 _fromFarmId, address _to, uint256 _amount) public {
        require(farms[_fromFarmId].owner == msg.sender, "Not the farm owner");
        require(farms[_fromFarmId].carbonCredits >= _amount, "Not enough carbon credits");
        farms[_fromFarmId].carbonCredits -= _amount;
        _transfer(msg.sender, _to, _amount);
    }
}
