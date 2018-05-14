pragma solidity ^0.4.21;

contract Exp {
    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }
    function npow(uint a, uint b) public pure returns (uint c) {
        if (b % 2 != 0) {
            c = a;
        }
        else {
            c = 1;
        }

        for (b /= 2; b != 0; b /= 2) {
            a = mul(a, a);

            if (b % 2 != 0) {
                c = mul(c, a);
            }
        }
    }
}
