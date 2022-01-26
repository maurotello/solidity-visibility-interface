
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Payable {
    // Payable address puede recibir Ether
    address payable public owner;

    // Payable constructor puede recibir Ether
    constructor() payable {
        owner = payable(msg.sender);
    }

    // Función para depositar Ether en este contrato.
    // Llame a esta función junto con algo de Ether.
    // El saldo de este contrato se actualizará automáticamente.
    function deposit() public payable {}

    // Llame a esta función junto con algo de Ether.
    // La función arrojará un error ya que esta función no es payable.
    function notPayable() public {}

    // Función para retirar todo el Ether de este contrato.
    function withdraw() public {
        // obtener la cantidad de Ether almacenada en este contrato
        uint amount = address(this).balance;

        // envía todo el Ether al propietario
        // El propietario puede recibir Ether ya que la dirección del propietario espayable
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    // Función para transferir Ether de este contrato a la dirección de la entrada
    function transfer(address payable _to, uint _amount) public {
        // Note que "_to" es declarada como payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }
    
    function getValue() public view returns (uint256) {
        // obtener la cantidad de Ether almacenada en este contrato
        uint amount = address(this).balance;
        return amount;
    }
}