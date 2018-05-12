pragma solidity ^0.4.21;

contract WealthManager {

    address partner_1;
    address partner_2;
    address heir;
    
    uint256 last_access;
    uint256 value;

    constructor(address _partner, address _heir) public payable {
        partner_1 = msg.sender;
        partner_2 = _partner;
        heir = _heir;
        
        last_access = now;
        
        value = msg.value;
    }

    function withdraw(uint256 amount) public {
        require(msg.sender == partner_1 || msg.sender == partner_2);

        require(now <= (last_access + 60 * 60 * 24 * 365));

        require(amount <= 1000000000000000000);

        require((value - amount) >= 0);

        value -= amount;
        last_access = now;

        msg.sender.transfer(amount);
    }

    function inherit() public {
        require(now >= (last_access + 60 * 60 * 24 * 365));
        
        selfdestruct(heir);
    }

    function pay() public payable {
        value += msg.value;
    }

}
