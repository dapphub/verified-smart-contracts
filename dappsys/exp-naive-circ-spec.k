requires "abstract-semantics.k"
requires "verification.k"

module EXP-NAIVE-CIRC-SPEC
  imports ETHEREUM-SIMULATION
  imports ABSTRACT-SEMANTICS
  imports VERIFICATION

  //Circularity claim. The loop begins at pc=136 and on the stack are (when called with 2^4)
  //Initially;  1,4,2
  //First loop: 2,3,2
  //snd   loop: 4,2,2
  //trd   loop: 8,1,2
  //frth  loop: 16,0,2
  //jump to 167, on the stack 16,0,2
  //return is on pc=??
  //hypothesis: [c, b, a]

    rule <k> #execute ... </k>
    <mode> NORMAL </mode>
    <schedule> BYZANTIUM </schedule>
    <callStack> .List </callStack>
    <memoryUsed> 0 </memoryUsed>
    <localMem> .Map </localMem>
    <previousGas> _ => _ </previousGas>
    <program> #asMapOpCodes(#dasmOpCodes(#parseByteStack("606060405260043610603f576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680632e4c697f146044575b600080fd5b3415604e57600080fd5b606b60048080359060200190919080359060200190919050506081565b6040518082815260200191505060405180910390f35b6000600190505b600082111560a7576098838260ad565b90508180600190039250506088565b92915050565b60008082148060ca5750828283850292508281151560c757fe5b04145b151560d457600080fd5b929150505600a165627a7a72305820b5ac4b0841e89c109f1ce1a7648ad4054ecc8db0d1653b0b9dda992e425298730029"), BYZANTIUM)) </program>

    <pc> 136 => 167 </pc>
    <gas> 300000000 => _ </gas>
    <static> false </static> // NOTE: non-static call
    <wordStack> C : B : A : 107 : WS => _ </wordStack>
    requires #sizeWordStack(WS) <Int 10
      andBool 0 <=Int A
      andBool 0 <=Int B
      andBool 1 <=Int C
      andBool A <=Int 10
      andBool B <=Int 10


endmodule

