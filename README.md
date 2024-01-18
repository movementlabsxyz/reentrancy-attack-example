# reentrancy-attack-example
An example of a reentrancy attack on EVM.

Re-entrancy is foremost a language-level vulnerability. It occurs because ownership is not properly managed in the code--usually owing to poor expressiveness or semantics. Move makes it less likely to suffer from re-entrancy attacks because you can only manipulate a resource in one ownership context at a time. However, it is still possible to write code that is vulnerable to re-entrancy attacks even in Move if you really try. 

By implementing EVM in Move, you don't necessarily inherit this ownership model. However, I believe it could possible to leverage Move's ownership model if (a) various EVM states are narrowly wrapped as Move resources and (b) interpreted opcodes are required to take ownership of these resources before they can be manipulated. This is likely more feasible at the bytecode level, hence a transpiler could be more effective against this objective. Bytecode would then need to be validated locally or during publication to ensure that it does not contain these re-entrancy vulnerabilities--which I believe is possible (I do think linearity is baked into the bytecode as well). 

Another far-flung alternative--but one which would certainly work--would be to translate at the language level. But, this is not commonly done because it is rarely practical outside of the narrowest of use cases. That being said, a very-well tuned LLM could potentially be leveraged. 

## How to run

### Pre-requisites
1. `forge` is installed on your device.
2. You have a EVM private key and set the environment variable `PRIVATE_KEY` to it.

### `PointsAttack`
This is a simple re-entrancy attack example that does not rely on payable or token interfaces. This example shows how reentrancy it can be exploited where critical sections are poorly managed.

To check this out against your chosen network, run the following command:

```bash
forge script PointsAttack --broadcast --chain-id <your-chain-id> --rpc-url <your-network> --sender <your-address> --private-key $PRIVATE_KEY
```

### `BankAttack`
A slightly more sophisticated example that exploits a re-entrancy vulnerability in a contract that implements a `payable` bank. This is a classic ETH reentrancy attack.

To check this out against your chosen network, run the following commands:

```bash
forge script DeployBank --broadcast --chain-id <your-chain-id> --rpc-url <your-network> --sender <your-address> --private-key $PRIVATE_KEY

export BANK_ADDRESS=<address-of-deployed-bank>

forge script ExecuteAttack --broadcast --chain-id <your-chain-id> --rpc-url <your-network> --sender <your-address> --private-key $PRIVATE_KEY --bank-address $BANK_ADDRESS
```
