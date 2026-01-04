// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {IERC20, SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleAirdrop {
    using SafeERC20 for IERC20; //we can call all functions defined in SafeERC20 on IERC20

    // some list of addresses
    // allow someone in the list to claim ERC-20 tokens
    error MerkleAirdrop__InvalidProof();
    error MerkleAirdrop__AlreadyClaimed();

    address[] claimers;
    bytes32 private immutable I_MERKLEROOT;
    IERC20 private immutable I_AIRDROPTOKEN;
    mapping(address claimer => bool Claimed) s_hasClaimed;

    event Claim(address account, uint256 amount);

    constructor(bytes32 merkelRoot, IERC20 airdropToken) {
        I_MERKLEROOT = merkelRoot;
        I_AIRDROPTOKEN = airdropToken;
    }

    function claim(address account, uint256 amount, bytes32[] calldata merkleProof) external {
        if (s_hasClaimed[account]) {
            revert MerkleAirdrop__AlreadyClaimed();
        }
        // calculate using the account and the amount, the hash -> leaf node
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(account, amount))));
        // hash it twice but why?
        // while using merkle proofs hash the values twice to avoid colision, but how does that work?
        // what is 2nd preimage attack?
        if (!MerkleProof.verify(merkleProof, I_MERKLEROOT, leaf)) {
            revert MerkleAirdrop__InvalidProof();
        }
        s_hasClaimed[account] = true;
        emit Claim(account, amount);
        I_AIRDROPTOKEN.safeTransfer(account, amount);
    }

    function getMerkleRoot() external view returns (bytes32) {
        return I_MERKLEROOT;
    }

    function getAirdropToken() external view returns (IERC20) {
        return I_AIRDROPTOKEN;
    }
}
