// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Bank.sol";
import "../src/BankAttack.sol";

contract BankTest is Test {
    Bank bank;
    BankAttack attacker;

    function setUp() public {
        // Deploy the Bank contract
        bank = new Bank();

        // Deploy the BankAttack contract
        attacker = new BankAttack(address(bank));

    }

    function testAttack() public {
        // Initial balance for the attacker contract (1 ether)
        vm.deal(address(attacker), 1 ether);

        // Attacker performs the attack
        attacker.attack{value: 1 ether}();

        // Asserts to verify the attack's success
        assertEq(address(attacker).balance, 2 ether); // Example assertion
        assertEq(address(bank).balance, 0); // Bank should be drained
    }
}
