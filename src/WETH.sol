// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WETH is ERC20 {
    mapping(address => uint256) userbalance;
    constructor () ERC20("Wrapped Ether", "WETH") {}

    error InsufficentFund();

    event DepositEvent (address indexed user, uint256 indexed amount);
    event withdrawEvent(uint indexed amount);

    function deposit() public payable {
        userbalance[msg.sender] += msg.value; 
        _mint(msg.sender, msg.value);
        emit DepositEvent(msg.sender, msg.value);
    }
    
    function withdraw(uint256 _amount) external {
        if(userbalance[msg.sender] < _amount){
            revert InsufficentFund();
        }
        
        userbalance[msg.sender] -= _amount; 
        _burn(address(this), _amount);
        payable(msg.sender).transfer(_amount);
        emit withdrawEvent(_amount);
    }
}