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
  
    rule
    <k> #execute => (RETURN RET_ADDR:Int 32 ~> _) </k>
    <exit-code> 1 </exit-code>
    <mode> NORMAL </mode>
    <schedule> BYZANTIUM </schedule>
    <analysis> .Map </analysis> // not part of evm

    <ethereum>
      <evm>
        <output> _ </output>
        <memoryUsed> 0 => _ </memoryUsed>
        <callDepth> CALL_DEPTH </callDepth>
        <callStack> _ => _ </callStack>
        <interimStates> _ </interimStates>
        <substateStack> _ </substateStack>
        <callLog> .Set </callLog> // for vmtest only
        <touchedAccounts> _ => _ </touchedAccounts>

        <txExecState>
          <program> #asMapOpCodes(#dasmOpCodes(#parseByteStack("0x606060405260043610603f576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680632e4c697f146044575b600080fd5b3415604e57600080fd5b606b60048080359060200190919080359060200190919050506081565b6040518082815260200191505060405180910390f35b6000600190505b600082111560a7576098838260ad565b90508180600190039250506088565b92915050565b60008082148060ca5750828283850292508281151560c757fe5b04145b151560d457600080fd5b929150505600a165627a7a72305820a046c345fda3920ecabd3cf31b45562355cbceaccd711fdc86a1c149af5c145d0029"), BYZANTIUM)) </program> 
          <programBytes> #parseByteStack("0x606060405260043610603f576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680632e4c697f146044575b600080fd5b3415604e57600080fd5b606b60048080359060200190919080359060200190919050506081565b6040518082815260200191505060405180910390f35b6000600190505b600082111560a7576098838260ad565b90508180600190039250506088565b92915050565b60008082148060ca5750828283850292508281151560c757fe5b04145b151560d457600080fd5b929150505600a165627a7a72305820a046c345fda3920ecabd3cf31b45562355cbceaccd711fdc86a1c149af5c145d0029") </programBytes>

          <id> ACCT_ID </id> // contract owner
          <caller> CALLER_ID </caller> // who called this contract; in the begining, origin // msg.sender

          <callData> _ </callData>

          <callValue> 0 </callValue>
          <wordStack> C : B : A : WS => C *Int A ^Int B : 0 : A : WS </wordStack>
//          <wordStack> WS => _ </wordStack>
          <localMem> .Map </localMem>
          <pc> 136 => 167 </pc>
          <gas> 31000000 => _ </gas>
          <previousGas> _ => _ </previousGas>

          <static> false </static> // NOTE: non-static call
        </txExecState>

        <substate>
          <selfDestruct> _ </selfDestruct>
          <log> _ => _ </log>
          <refund> _ => _ </refund> // TODO: more detail
        </substate>

        <gasPrice> _ </gasPrice>
        <origin> ORIGIN_ID </origin> // who fires tx

        <previousHash> _ </previousHash>
        <ommersHash> _ </ommersHash>
        <coinbase> _ </coinbase>
        <stateRoot> _ </stateRoot>
        <transactionsRoot> _ </transactionsRoot>
        <receiptsRoot> _ </receiptsRoot>
        <logsBloom> _ </logsBloom>
        <difficulty> _ </difficulty>
        <number> _ </number>
        <gasLimit> _ </gasLimit>
        <gasUsed> _ </gasUsed>
        <timestamp> _ </timestamp>
        <extraData> _ </extraData>
        <mixHash> _ </mixHash>
        <blockNonce> _ </blockNonce>

        <ommerBlockHeaders> _ </ommerBlockHeaders>
        <blockhash> _ </blockhash>
      </evm>

      <network>
        <activeAccounts> SetItem(ACCT_ID) _:Set </activeAccounts>

        <accounts>
          _
       // ... // TODO: fix
        </accounts>

        <txOrder> _ </txOrder>
        <txPending> _ </txPending>
        <messages> _ </messages>
      </network>
    </ethereum>
    requires A <=Int 5
    andBool B <=Int 5
    andBool C <=Int A ^Int B
    andBool A >=Int 0
    andBool B >=Int 0
    andBool C >=Int 0
    andBool 0 <=Int CALL_DEPTH
    andBool CALL_DEPTH <Int 100
    andBool #sizeWordStack(WS) <Int 10

endmodule

