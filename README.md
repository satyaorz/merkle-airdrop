Merkle-Airdrop

what is a merkle tree?
=> Merkle tree(also known as hash tree) is type of data stucture used to efficiently verify the integrity and inclusion of data within a large dataset.

=> it is a binanry tree where every leaf node is a cryptographic hash of a data block, and every non-leaf node is the hash of two of its children nodes. 
example:
```
        a
    b          c
d       e  f       g
```

if the above is a binary tree then, "d","e","f","g" are the leaf node and "a" is the root node, then "d","e","f","g" are the cryptographic hash of a datablock and b = hash(d,e), similarly c = hash(f,g) and a = hash(b,c).

merkle proof: A Merkle Proof is the minimal set of hashes needed to compute the path from a leaf node up to the Merkle Root.

=> A Merkle Proof is the specific list of sibling hashes required to reconstruct the Merkle Root from a specific leaf node. By re-calculating the root using this path, a verifier can mathematically prove the leaf belongs to the dataset without having access to the entire tree.