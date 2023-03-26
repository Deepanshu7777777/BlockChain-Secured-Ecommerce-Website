 /*
 This file is used to keep track of the migrations of smart contracts from one version to another.
 Migrations contract has a variable owner that is set to the address of the contract deployer. There is also a variable last_completed_migration that keeps track of the last completed migration.
 */


// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;  //This specifies the version of Solidity that the contract is written in. 

contract Migrations {                 //This defines the contract named "Migrations".
  address public owner = msg.sender;   
  uint public last_completed_migration; 
  modifier restricted() {   //This creates a modifier called restricted that restricts access to certain functions to the contract's owner
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _;
  }

  function setCompleted(uint completed) public restricted {  
    last_completed_migration = completed;                   
  }
}
