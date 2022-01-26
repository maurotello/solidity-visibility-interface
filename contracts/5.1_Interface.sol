
/* 
TODO:
    corregir errores al cambiar a versión ^0.8.3
    pragma solidity ^0.8.3;
*/

pragma solidity 0.4.19;

// A simple interface
interface InterfaceExample {
    // Functions having only
    // declaration not definition
    function getStr() public view returns (string memory);

    function setValue(uint256 _num1, uint256 _num2) public;

    function add() public view returns (uint256);
}

// Contract that implements interface
contract thisContract is InterfaceExample {
    
    // Private variables
    uint256 private num1;
    uint256 private num2;

    // Function definitions of functions
    // declared inside an interface
    function getStr() public view returns (string memory) {
        return "GeeksForGeeks";
    }

    // Function to set the values
    // of the private variables
    function setValue(uint256 _num1, uint256 _num2) public {
        num1 = _num1;
        num2 = _num2;
    }

    // Function to add 2 numbers
    function add() public view returns (uint256) {
        return num1 + num2;
    }
}

contract call {
    //Creating an object
    InterfaceExample obj;

    function call() public {
        obj = new thisContract();
    }

    // Function to print string
    // value and the sum value
    function getValue() public returns (uint256) {
        obj.getStr;
        obj.setValue(10, 16);
        return obj.add();
    }
}
