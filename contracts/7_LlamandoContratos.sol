/*

Un contrato  puede llamar a otros contratos de 2 formas.
La forma más fácil de hacerlo es simplemente llamarlo, como Contrato.funciona(x, y, z).
Otra forma de llamar a otros contratos es utilizar la llamada de bajo nivel.
No se recomienda este método.

call es una función de bajo nivel para interactuar con otros contratos.
Este es el método recomendado para usar cuando solo está enviando Ether 
llamando a la función de fallback.
Sin embargo, no es la forma recomendada de llamar a funciones existentes.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Callee {

    uint256 private x;
    uint256 private value;

    function setX(uint256 _x) public returns (uint256) {
        x = _x;
        return x;
    }

    function setXandSendEther(uint256 _x)
        public
        payable
        returns (uint256, uint256)
    {
        x = _x;
        value = msg.value;

        return (x, value);
    }
}

contract Caller {
    function setX(Callee _callee, uint256 _x) public {
        uint256 x = _callee.setX(_x);
    }

    function setXFromAddress(address _addr, uint256 _x) public {
        Callee callee = Callee(_addr);
        callee.setX(_x);
    }

    function setXandSendEther(Callee _callee, uint256 _x) public payable {
        (uint256 x, uint256 value) = _callee.setXandSendEther{value: msg.value}(
            _x
        );
    }
}
