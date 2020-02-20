pragma solidity ^0.5.8;

contract MyToken {
    mapping (address => uint) balances;

    modifier onlyPayloadSize(uint size) {
        assert(msg.data.length == size + 4);
        _;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor() public {
        balances[tx.origin] = 10000;
    }

    function sendCoin(address to, uint amount) public onlyPayloadSize(2 * 32) returns (bool sufficient) {
        if(balances[msg.sender] < amount) return false;
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function getBalance(address addr) public view returns (uint) {
        return balances[addr];
    }
}