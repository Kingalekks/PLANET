// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract PLANET {
    string public tokenName;
    string public tokenSymbol;
    uint8 public tokenDecimal;
    int public totalSupply;
    address private owner;
    address public payer;
    address public origin;
    address public minter;
    uint public value;
    mapping(address => uint256) public balance;
    event send(address from, address to, uint256 amount);

    constructor() {
        tokenName = "PLANET";
        tokenSymbol = "PLANET";
        tokenDecimal = 18;
        totalSupply = 9130325619;
        minter = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller must be owner");
        _;
    }
    
    function pay() public payable {
        payer = msg.sender;
        origin = tx.origin;
        value = msg.value;
    }

    function getBlockInfo() public view returns (uint256, uint256, uint256) {
        return (
            block.number,
            block.timestamp,
            block.chainid
        );
    }

    function sent(address receiver, uint256 amount) public {
        require(amount <= balance[msg.sender], "Insufficient Balance");
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        emit send(msg.sender, receiver, amount);
    } 

    function mint(address receiver, uint256 amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);
        balance[receiver] += amount;
    }
}