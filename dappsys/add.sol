pragma solidity ^0.4.21;

import "ds-math/math.sol";

contract Add is DSMath {
  function addit(uint x, uint y) public pure returns (uint z) {
    z = add(x, y);
  }
}
