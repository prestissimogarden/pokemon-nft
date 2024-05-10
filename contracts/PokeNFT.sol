// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PokeNFT is ERC721 {
    struct Pokemon {
        string name;
        uint level;
        string img;
    }
    Pokemon[] public pokemons;
    address public owner;

    constructor() ERC721("PokeNFT", "POKE") {
        owner = msg.sender;
    }

    modifier onlyOwnderOf(uint _monsterId) {
        require(
            ownerOf(_monsterId) == msg.sender,
            "Only the owner can use this pokemon"
        );
        _;
    }

    function battle(
        uint _attacker,
        uint _defender
    ) public onlyOwnderOf(_attacker) {
        Pokemon storage attacker = pokemons[_attacker];
        Pokemon storage defender = pokemons[_defender];

        if (attacker.level > defender.level) {
            attacker.level += 2;
            defender.level += 1;
        } else {
            attacker.level += 1;
            defender.level += 2;
        }
    }

    function createNewPoke(
        string memory _name,
        address _to,
        string memory _img
    ) public {
        require(msg.sender == owner, "Only the owner can create new pokemons");
        uint id = pokemons.length;
        pokemons.push(Pokemon(_name, 1, _img));
        // Open Zeppelin function to coin a token
        _safeMint(_to, id);
    }
}
