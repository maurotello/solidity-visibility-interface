// Las funciones y las variables de estado deben declarar si
// son accesibles por otros contratos.

// Las funciones se pueden declarar como

// público: cualquier contrato y cuenta puede llamar
// privado: solo dentro del contrato que define la función
// interno: solo contrato interno que hereda una función interna
// externo: solo otros contratos y cuentas pueden llamar
// Las variables de estado se pueden declarar como públicas,
// privadas o internas, pero no externas.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Base {
    // La función privada solo se puede llamar
    // - dentro de este contrato
    // Los contratos que heredan este contrato no pueden llamar a esta función.
    function privateFunc() private pure returns (string memory) {
        return "private function called";
    }

    function testPrivateFunc() public pure returns (string memory) {
        return privateFunc();
    }

    // Se puede llamar a la función interna
    // - dentro de este contrato
    // - contratos internos que heredan este contrato
    function internalFunc() internal pure returns (string memory) {
        return "internal function called";
    }

    function testInternalFunc() public pure virtual returns (string memory) {
        return internalFunc();
    }

    // Se pueden llamar funciones públicas
    // - dentro de este contrato
    // - contratos internos que heredan este contrato
    // - por otros contratos y cuentas
    function publicFunc() public pure returns (string memory) {
        return "public function called";
    }

    // Las funciones externas solo se pueden llamar
    // - por otros contratos y cuentas
    function externalFunc() external pure returns (string memory) {
        return "external function called";
    }

    // Esta función no se compilará ya que estamos intentando llamar
    // una función externa aquí.
    // function testExternalFunc() public pure returns (string memory) {
    //     return externalFunc();
    // }

    // State variables
    string private privateVar = "my private variable";
    string internal internalVar = "my internal variable";
    string public publicVar = "my public variable";
    // Las variables de estado no pueden ser externas,
    // por lo que este código no se compilará.
    // string external externalVar = "my external variable";
}

contract Child is Base {
    // Los contratos heredados no tienen acceso a funciones privadas
    // y variables de estado.
    // function testPrivateFunc() public pure returns (string memory) {
    //     return privateFunc();
    // }

    // Llamada a la función interna dentro de los contratos secundarios.
    function testInternalFunc() public pure override returns (string memory) {
        return internalFunc();
    }

    // Esta función no se compilará ya que estamos intentando llamar
    // una función privada aquí.
    // function testPrivateFunc() public pure override returns (string memory) {
    //     return privateFunc();
    // }
}

contract callExternal {
    //Creamos el objeto
    Base objBase;

    constructor() {
        objBase = new Base();
    }

    // Función para imprimir cadena
    // valor y el valor de la suma
    function getExternalValue() public view returns (string memory) {
        return objBase.externalFunc();
    }

    function getPublicValue() public view returns (string memory) {
        return objBase.publicFunc();
    }
}
