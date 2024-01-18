// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    mapping (address => uint) public balances;

    function deposit() public payable {
        require(msg.value > 0, "funds needed to set balance");
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint balance = balances[msg.sender];
        require(balance > 0, "insufficient balance");

        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "transfer failed");

        balances[msg.sender] = 0;
    }
}
