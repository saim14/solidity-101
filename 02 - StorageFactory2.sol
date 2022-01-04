// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;
import "./00 - SimpleStorage.sol";

// Inheritance
contract StorageFactory  is SimpleStorage{
    SimpleStorage[] public simpleStorageArray;
    function createSimpleStorageContact() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public{
        // Address, ABI 
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageNumber) public view returns(uint256){
       return SimpleStorage(address(simpleStorageArray[_simpleStorageNumber])).get();
        
    }
}