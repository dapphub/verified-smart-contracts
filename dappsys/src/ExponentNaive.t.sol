pragma solidity ^0.4.21;

import "ds-test/test.sol";

import "./ExponentNaive.sol";

contract ExponentNaiveTest is DSTest {
    exp naive;

    function setUp() public {
        naive = new exp();
    }

    function test_simple() public {
        uint r = naive.pow(2, 4);
        assert(r == 16);
    }
}
