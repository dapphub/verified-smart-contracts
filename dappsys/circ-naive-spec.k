requires "abstract-semantics.k"
requires "verification.k"

module CIRC-NAIVE-SPEC
  imports ETHEREUM-SIMULATION
  imports ABSTRACT-SEMANTICS
  imports VERIFICATION

  // circ-naive
  rule
    <k> #execute => #execute </k>
    <exit-code> 1 </exit-code>
    <mode> NORMAL </mode>
    <schedule> BYZANTIUM </schedule>
    <analysis> .Map </analysis> // not part of evm

    <ethereum>
      <evm>
        <output> _ </output>
        <memoryUsed> MU </memoryUsed>
        <callDepth> CALL_DEPTH </callDepth>
        <callStack> _ => _ </callStack>
        <interimStates> _ </interimStates>
        <substateStack> _ </substateStack>
        <callLog> .Set </callLog> // for vmtest only
        <touchedAccounts> _ => _ </touchedAccounts>

        <txExecState>
          <program> #asMapOpCodes(#dasmOpCodes(#parseByteStack("0x606060405260043610603f576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680632e4c697f146044575b600080fd5b3415604e57600080fd5b606b60048080359060200190919080359060200190919050506081565b6040518082815260200191505060405180910390f35b6000600190505b600082111560a7576098838260ad565b90508180600190039250506088565b92915050565b60008082148060ca5750828283850292508281151560c757fe5b04145b151560d457600080fd5b929150505600a165627a7a72305820b5ac4b0841e89c109f1ce1a7648ad4054ecc8db0d1653b0b9dda992e425298730029"), BYZANTIUM)) </program>
          <programBytes> #parseByteStack("0x606060405260043610603f576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680632e4c697f146044575b600080fd5b3415604e57600080fd5b606b60048080359060200190919080359060200190919050506081565b6040518082815260200191505060405180910390f35b6000600190505b600082111560a7576098838260ad565b90508180600190039250506088565b92915050565b60008082148060ca5750828283850292508281151560c757fe5b04145b151560d457600080fd5b929150505600a165627a7a72305820b5ac4b0841e89c109f1ce1a7648ad4054ecc8db0d1653b0b9dda992e425298730029") </programBytes>

          <id> ACCT_ID </id> // contract owner
          <caller> CALLER_ID </caller> // who called this contract; in the begining, origin // msg.sender

          <callData> _ </callData>

          <callValue> 0 </callValue>
          <wordStack> C : B : A : WS => C *Int (A ^Int B) : 0 : A : WS </wordStack>
          <localMem> _ </localMem>
          <pc> 136 => 167 </pc>
          <gas> G => _ </gas>
          <previousGas> _ => _ </previousGas>

          <static> false </static> // NOTE: non-static call
        </txExecState>

        <substate>
          <selfDestruct> _ </selfDestruct>
          <log> _ </log>
          <refund> _ </refund> // TODO: more detail
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
        <timestamp> NOW </timestamp> // block.timestamp // now
        <extraData> _ </extraData>
        <mixHash> _ </mixHash>
        <blockNonce> _ </blockNonce>

        <ommerBlockHeaders> _ </ommerBlockHeaders>
        <blockhash> _ </blockhash>
      </evm>

      <network>
        <activeAccounts> SetItem(ACCT_ID) _:Set </activeAccounts>

        <accounts>
          <account>
            <acctID> ACCT_ID </acctID>
            <balance> _ </balance>
            <code> #parseByteStack("0x606060405260043610603f576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680632e4c697f146044575b600080fd5b3415604e57600080fd5b606b60048080359060200190919080359060200190919050506081565b6040518082815260200191505060405180910390f35b6000600190505b600082111560a7576098838260ad565b90508180600190039250506088565b92915050565b60008082148060ca5750828283850292508281151560c757fe5b04145b151560d457600080fd5b929150505600a165627a7a72305820b5ac4b0841e89c109f1ce1a7648ad4054ecc8db0d1653b0b9dda992e425298730029") </code>
            <storage>
_
            </storage>
            <nonce> _ </nonce>
          </account>
       // ... // TODO: fix
        </accounts>

        <txOrder> _ </txOrder>
        <txPending> _ </txPending>
        <messages> _ </messages>
      </network>
    </ethereum>
    requires 0 <=Int ACCT_ID    andBool ACCT_ID    <Int (2 ^Int 160)
     andBool 0 <=Int CALLER_ID  andBool CALLER_ID  <Int (2 ^Int 160)
     andBool 0 <=Int ORIGIN_ID  andBool ORIGIN_ID  <Int (2 ^Int 160)
     andBool 0 <=Int NOW        andBool NOW        <Int (2 ^Int 256)
     andBool 0 <=Int CALL_DEPTH andBool CALL_DEPTH <Int 1024
andBool MU <Int 10
andBool #sizeWordStack(WS) <Int 10
andBool #sizeWordStack(WS) >Int 2
andBool 0 <=Int A
andBool A <Int pow256
andBool 0 <=Int B
andBool B <Int pow256
andBool 0 <=Int C
andBool C <Int pow256
andBool 0 <=Int (C *Int (A ^Int B))
andBool (C *Int (A ^Int B)) <Int pow256
andBool G >=Int (100000000 *Int B) +Int 1000000000




endmodule

