# Family wealth management

## Problem statement

Implement a smart contract for shared wealth management for families.

- The contract should have exactly two owners.
- The contract should store the funds of the owners in ether.
- Only the owners can access the funds.
- There is a limit of 1 ether for single withdraws.
- In case the funds are not accessed for a whole year, an heir inherits them automatically.

## Example scenario

Alice and Bob create a contract with 10 ether initial balance, setting their daughter, Carol, as their heir. Every time they receive their salary, they transfer it to the contract. Every time they need money, they withdraw money from the contract, knowing that they can only withdraw 1 ether at a time.

Unfortunately, Alice and Bob both lose access to their private keys. After one year, but not before, Carol is able to withdraw all the ether from the contract.

## Contract interface

- `constructor: function WealthManager(address partner, address heir) payable`
  - The creator of the contract (`msg.sender`) is the first owner.
  - `partner` is the second owner.
  - `heir` is the heir.

- `withdraw: function withdraw(uint256 amount)`
  - Sends amount wei to the sender of the transaction.
  - Succeeds only if the sender is one of the owners and amount is not over the withdraw limit.

- `inherit: function inherit()`
  - Send all the funds to the heir's address.
  - Anyone can call this function.
  - Succeeds only if the contract has not been accessed for at least one year.
  - After the transfer, the contract should become inactive, i.e. all subsequent transactions should fail (e.g. by using `selfdestruct`).

- `fallback: function pay() payable`
  - Receives ether from any address.

## Start Parity blockchain

```
$ make up
```

## Remove blockchain data

```
$ make down
```
