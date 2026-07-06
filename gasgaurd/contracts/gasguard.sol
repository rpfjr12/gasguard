// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ProfitHandler.sol";
import "./mocks/MockDEX.sol";
import "./mocks/MockToken.sol";

contract GasGuard {
    address public owner;
    ProfitHandler public profitHandler;

    constructor(address _profitHandler) {
        owner = msg.sender;
        profitHandler = ProfitHandler(_profitHandler);
    }

    function performArbitrage(
        address tokenA,
        address tokenB,
        uint256 amountIn
    ) external {
        uint256 startGas = gasleft();

        // Approve DEX
        MockToken(tokenA).approve(address(MockDEX(tokenA)), amountIn);

        // Execute swap
        uint256 amountOut = MockDEX(tokenA).swap(tokenA, tokenB, amountIn);

        // Calculate profit
        uint256 grossProfit = amountOut;

        // Gas reimbursement
        uint256 gasUsed = startGas - gasleft() + 21000;
        uint256 gasCost = gasUsed * tx.gasprice;

        // Send profit + reimburse gas
        profitHandler.handleProfit(msg.sender, owner, grossProfit, gasCost);
    }
}
