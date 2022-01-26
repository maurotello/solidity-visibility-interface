// Las variables se declaran como almacenamiento, memoria o calldata
//  para especificar explícitamente la ubicación de los datos.

// storge - la variable es una variable de estado (almacenar en blockchain)
// memory: la variable está en la memoria y existe mientras se llama a una función
// calldata: ubicación de datos especial que contiene argumentos de función,
// solo disponible para funciones externas

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

//Ejemplo CallData vs Memory
contract CallDataVsMemoryLocation {
    string stringTest;

    function memoryTest(string memory _exampleString)
        public
        pure
        returns (string memory)
    {
        _exampleString = "example"; // podemos modificar memory
        string memory newString = _exampleString; // podemos usar memory dentro de la función
        return newString; // podemos retornar memory
    }

    function calldataTest(string calldata _exampleString)
        external
        pure
        returns (string memory)
    {
        // No podemos modificar _exampleString
        // pero podemos retornarla
        return _exampleString;
    }
}

contract DataLocations {
    uint256[] public arr;
    mapping(uint256 => address) map;
    struct MyStruct {
        uint256 foo;
    }
    mapping(uint256 => MyStruct) myStructs;

    function testFunctionF() public {
        // call testFunction_f with state variables
        testFunction_f(arr, map, myStructs[1]);

        // get a struct from a mapping
        MyStruct storage myStruct = myStructs[1];

        // create a struct in memory
        MyStruct memory myMemStruct = MyStruct(0);
    }

    function testFunction_f(
        uint256[] storage _arr,
        mapping(uint256 => address) storage _map,
        MyStruct storage _myStruct
    ) internal {
        // do something with storage variables
    }

    // You can return memory variables
    function testFunction_g(uint256[] memory _arr)
        public
        returns (uint256[] memory)
    {
        // do something with memory array
    }

    function testFunction_h(uint256[] calldata _arr) external {
        // do something with calldata array
    }
}
