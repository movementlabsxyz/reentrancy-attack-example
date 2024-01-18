// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Points {
    mapping(address => uint) public balances;

    function deposit(uint _amount) public {
        require(_amount > 0, "Amount must be greater than zero");
        balances[msg.sender] += _amount;
    }

    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        uint new_amount = balances[msg.sender] - _amount;
        
        // Dispatch external call before updating the balance
        (bool success, ) = msg.sender.call{value: 0}("");
        require(success, "External call failed");
        
        balances[msg.sender] = new_amount;
    }

}