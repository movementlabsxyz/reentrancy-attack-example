// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Bank.sol";
import "../src/BankAttack.sol";

contract DeployAttacker is Script {
    function run() external {

        address bankAddress = vm.envAddress("BANK_ADDRESS");
        vm.startBroadcast();

        // Deploy BankAttack contract with the address of the deployed Bank
        new BankAttack(bankAddress);

        vm.stopBroadcast();
    }
}
