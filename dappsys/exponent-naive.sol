contract exp {
    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }
    function pow(uint a, uint b) public pure returns (uint c) {
      c = 1;
      for (b;b > 0; b--) {
	    c = mul(a, c);
        }
    }
}
