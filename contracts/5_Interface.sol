/**

Las interfaces son las mismas que los contratos abstractos 
creados mediante el uso de una palabra clave de interface,
también conocido como contrato abstracto puro. Las interfaces no tienen definición ni
variables de estado, constructores o cualquier función con implementación, solo contienen
declaraciones de funciones, es decir, las funciones en las interfaces no tienen declaraciones.
Las funciones de interfaz pueden ser sólo de tipo externo. Pueden heredar de otras interfaces,
pero no pueden heredar de otros contratos. Una interfaz puede tener enum, estructuras que
se puede acceder mediante la notación de puntos del nombre de la interfaz.

Ejemplo: En el siguiente ejemplo, el contrato thisContract implementa una interfaz
InterfaceExample e implementa todas las funciones de la interfaz.
*/

pragma solidity ^0.8.3;

// Una interface simple
interface InterfaceExample {
    // Funciones que solo tienen
    // declaración, no definición
    function getStr() external view returns (string memory);

    function setValue(uint256 _num1, uint256 _num2) external;

    function add() external view returns (uint256);
}

// Contrato que implementa la interface
contract thisContract is InterfaceExample {
    // Private variables
    uint256 private num1;
    uint256 private num2;

    // Definiciones de funciones
    // declaradas dentro de una interfaz
    function getStr() public pure override returns (string memory) {
        return "EducacionIT";
    }

    // Función para establecer los valores
    // de las variables privadas
    function setValue(uint256 _num1, uint256 _num2) public override {
        num1 = _num1;
        num2 = _num2;
    }

    // Función para sumar 2 valores
    function add() public view override returns (uint256) {
        return num1 + num2;
    }
}

// contrato que llama al anterior
contract call {
    // creamos un objeto del tipo de la interface
    InterfaceExample obj;

    // instanciamos un nuevo contrato thisContract
    constructor() {
        obj = new thisContract();
    }

    // Función para imprimir cadena
    // valor y el valor de la suma
    function getValue() public returns (uint256) {
        obj.getStr;
        obj.setValue(10, 16);
        return obj.add();
    }
}
