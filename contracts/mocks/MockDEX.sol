// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./MockToken.sol";

contract MockDEX {
    function swap(address tokenA, address tokenB, uint256 amountIn)
        external
        returns (uint256)
    {
        MockToken(tokenA).transfer(address(this), amountIn);

        uint256 amountOut = amountIn + (amountIn / 100); // +1% profit

        MockToken(tokenB).transfer(msg.sender, amountOut);

        return amountOut;
    }
}
