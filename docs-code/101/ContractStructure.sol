// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleStorage{
    // State variable
    uint public storedData;
    address public seller;

    // Struct type (To make custom data type)
    struct people {
        bool isSeller;
        address peopleAddress;
        uint id;
    }

    // Enum type 
    enum State {Created, Locked, Inactive}

    // General function
    function store(uint _x) public returns(uint){
        storedData = helper(_x);
        return storedData;
    }

    // Modifier - that applied to function abort()
    modifier onlySeller(){
        require(msg.sender == seller, "Only seller can call this");
        _;
    }
    // Modifier usage
    function abort() public view onlySeller { 
        // .... 
    }

    // Event
    event StoredDataIncreased(uint increasedBy, uint stData);

    // Error
    error ZeroProvidedToIncreased(uint store_data);

    function increase(uint num) public returns(uint){
        if(num == 0){
            revert ZeroProvidedToIncreased(0); // Uses of error
        }
        storedData+=num;
        emit StoredDataIncreased(num, storedData); // Uses of event
        return storedData;
    }

}

// Helper function defined outside of a contract
function helper(uint x) pure returns(uint) {
    return x**2; 
}
    

contract Test {
    //...
}