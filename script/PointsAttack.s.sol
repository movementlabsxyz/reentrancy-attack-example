// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Points.sol";
import "../src/Attacker.sol";

contract PointsAttack is Script {
    function run() external {
        // Deploy the Points contract
        Points points = new Points();
        Points morePoints = new Points();
        
        // Deploy the Attacker with the Points contract address
        Attacker attacker = new Attacker(
            address(points),
            address(morePoints)
        );

        // Initial balance of the attacker
        uint initialBalance = morePoints.balances(address(attacker));

        // Trigger the reentrancy attack
        attacker.attack();

        // Final balance of the attacker after the attack
        uint finalBalance = morePoints.balances(address(attacker));

        // Verify that the attacker's balance increased
        assert(finalBalance > initialBalance);

        // Verify that the Points contract balance is zero
        // assert(points.balances(address(points)) == 0);
    }
}
