// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ProfitHandler {
    function handleProfit(
        address caller,
        address owner,
        uint256 grossProfit,
        uint256 gasCost
    ) external {
        require(grossProfit > gasCost, "Not profitable");

        uint256 netProfit = grossProfit - gasCost;

        payable(caller).transfer(gasCost);
        payable(owner).transfer(netProfit);
    }

    receive() external payable {}
}
