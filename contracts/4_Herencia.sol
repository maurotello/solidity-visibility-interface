/**
Solidity admite herencia múltiple. Los contratos pueden heredar otro contrato 
mediante el uso de la palabra clave is.
La función que va a ser sobreescrita (overridden) por un contrato hijo debe 
declararse como virtual.
La función que va a sobreescribir una función del padre debe usar la palabra clave override.
El orden de la herencia es importante.
Debe enumerar los contratos principales en el orden de "más similar a la base" a "más derivados".
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

/* Gráfico de herencia
    A
   / \
  B   C
 / \ /
F  D,E

*/

contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}

// Los contratos heredan otros contratos mediante el uso de la palabra clave 'is'.
contract B is A {
    // Override A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is A {
    // Override A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "C";
    }
}

// Los contratos pueden heredar de varios contratos principales.
// Cuando se llama a una función que se define varias veces en
// diferentes contratos, los contratos principales se buscan desde
// de derecha a izquierda

contract D is B, C {
    // D.foo() returns "C"
    // ya que C es el contrato padre más correcto con la función foo ()
    function foo() public pure override(B, C) returns (string memory) {
        return super.foo();
    }
}

contract E is C, B {
    // E.foo() returns "B"
    // dado que B es el contrato padre más correcto con la función foo ()
    function foo() public pure override(C, B) returns (string memory) {
        return super.foo();
    }
}

// La herencia debe ordenarse de "más similar a la base" a "más derivada".
// Cambiar el orden de A y B arrojará un error de compilación.
contract F is A, B {
    function foo() public pure override(A, B) returns (string memory) {
        return super.foo();
    }
}

// An example ERC20 token:

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.4.0-solc-0.7/contracts/token/ERC20/ERC20.sol";

// // SPDX-License-Identifier: MIT
// pragma solidity ^0.7.0;
// contract Token is ERC20 {

//     constructor () ERC20("Token", "TKN") {
//         _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
//     }
// }
