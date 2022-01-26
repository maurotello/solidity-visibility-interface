// Las bibliotecas son similares a los contratos, pero no se pueden declarar
// variablse de estado ni enviar ether.

// Implementación de la Library con la palabra clave "For"
// Una biblioteca se puede definir en el mismo contrato y también
// se puede importar desde el exterior utilizando las declaraciones de importación.

// Ejemplo:

// import <libraryName> from “./library-file.sol”;
// Un solo archivo puede contener varias bibliotecas que se pueden especificar
// usando llaves en la declaración de importación separadas por una coma.
// Se puede acceder a una biblioteca dentro del contrato inteligente utilizando
//  la palabra clave "for".

// Syntax:

// <libraryName> for <dataType>
// La declaración anterior se puede utilizar para adjuntar funciones de biblioteca a cualquier tipo.
// libraryName es el nombre de la biblioteca deseada para importar, dataType es la variable
// tipo para el que queremos acceder a la biblioteca.
// Todos los miembros de la biblioteca también pueden ser
// utilizado por el operador comodín (*).

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

library SafeMath {
    function add(uint256 x, uint256 y) internal pure returns (uint256) {
        uint256 z = x + y;
        require(z >= x, "uint overflow");

        return z;
    }
}

library Math {
    function sqrt(uint256 y) internal pure returns (uint256 z) {
        if (y > 3) {
            z = y;
            uint256 x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
        // else z = 0 (default value)
    }
}

contract TestSafeMath {
    using SafeMath for uint256;

    uint256 public MAX_UINT = 2**256 - 1;

    function testAdd(uint256 x, uint256 y) public pure returns (uint256) {
        return x.add(y);
    }

    function testSquareRoot(uint256 x) public pure returns (uint256) {
        return Math.sqrt(x);
    }
}

// Función de matriz para eliminar el elemento en el índice y reorganizar la matriz
// para que no haya espacios entre los elementos.
library Array {
    function remove(uint256[] storage arr, uint256 index) public {
        // Mueva el último elemento al lugar para eliminar
        require(arr.length > 0, "Can't remove from empty array");
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }
}

contract TestArray {
    using Array for uint256[];

    uint256[] public arr;

    function testArrayRemove() public {
        for (uint256 i = 0; i < 3; i++) {
            arr.push(i);
        }

        arr.remove(1);

        assert(arr.length == 2);
        assert(arr[0] == 0);
        assert(arr[1] == 2);
    }
}
