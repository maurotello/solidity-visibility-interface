
/*

¿Cómo enviar Ether?
Puede enviar Ether a otros contratos mediante 
    - transfer (2300 gas, throws error)
    - send (2300 gas, returns bool)
    - call (forward all gas or set gas, returns bool)

¿Cómo recibir Ether?
Un contrato que recibe Ether debe tener al menos una de las funciones siguientes
    - receive() external payable
    - fallback() external payable

Se llama a receive () si msg.data está vacío; de lo contrario, se llama a fallback ().

¿Qué método deberías utilizar?
     - Call en combinación con el protector de reentrada es el método 
     recomendado para usar después de diciembre de 2019.

Protéjase contra la reentrada por
     - hacer todos los cambios de estado antes de llamar a otros contratos
     - usando el modificador de guardia de reentrada
*/

/*
¿Qué función se llama, fallback () o receive ()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
*/


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

// ejemplo de contrato que RECIBE ETH

contract ReceiveEther {
    
    // Payable constructor puede recivir Ether
    constructor() payable {
        
    }
    // Función para recibir Ether. msg.data debe estar vacío
    receive() external payable {}

    //  se llama a la función Fallback cuando msg.data no está vacío
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

// ejemplo de contrato que ENVÍA ETH

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        // Esta función ya no se recomienda para enviar Ether.
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // Send devuelve un valor booleano que indica éxito o fracaso.
        // Esta función ya no se recomienda para enviar Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // Cacll devuelve un valor booleano que indica éxito o fracaso.
        // Este es el método recomendado actualmente para usar.
        // _receiver.call.value(msg.value).gas(20317)();
        
        (bool sent, bytes memory data) = _to.call{value: msg.value, gas: 20317}("");
        
        require(sent, "Failed to send Ether");
    }
}