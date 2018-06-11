requires "abstract-semantics.k"
requires "verification.k"

module ADD-SUCCESS-SPEC
  imports ETHEREUM-SIMULATION
  imports ABSTRACT-SEMANTICS
  imports VERIFICATION

  // transfer-success-1
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
          <program> #asMapOpCodes(#dasmOpCodes(#parseByteStack("0x608060405260043610603f576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063771602f7146044575b600080fd5b348015604f57600080fd5b5060766004803603810190808035906020019092919080359060200190929190505050608c565b6040518082815260200191505060405180910390f35b6000828284019150811015151560a157600080fd5b929150505600a165627a7a72305820972bee37ba897d105b40bea36a1eed18923ae402e77c7f4e0240a80f0cf3f3f70029"), BYZANTIUM)) </program> 
          <programBytes> #parseByteStack("0x608060405260043610603f576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063771602f7146044575b600080fd5b348015604f57600080fd5b5060766004803603810190808035906020019092919080359060200190929190505050608c565b6040518082815260200191505060405180910390f35b6000828284019150811015151560a157600080fd5b929150505600a165627a7a72305820972bee37ba897d105b40bea36a1eed18923ae402e77c7f4e0240a80f0cf3f3f70029") </programBytes>

          <id> ACCT_ID </id> // contract owner
          <caller> CALLER_ID </caller> // who called this contract; in the begining, origin // msg.sender

          <callData> #abiCallData("add", #uint256(X), #uint256(Y)) </callData>

          <callValue> 0 </callValue>
//          <wordStack> .WordStack => _ </wordStack>
          <wordStack> WS => _ </wordStack>
          <localMem> .Map => ( .Map[ RET_ADDR := #asByteStackInWidth(X +Int Y, 32) ] _:Map ) </localMem>
          <pc> 0 => _ </pc>
          <gas> 100000 => _ </gas>
          <previousGas> _ => _ </previousGas>

          <static> _ </static> // NOTE: non-static call
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
    requires X +Int Y <Int pow256
    andBool X >=Int 0
    andBool Y >=Int 0
    andBool 0 <=Int CALL_DEPTH
    andBool CALL_DEPTH <Int 1024
    andBool #sizeWordStack(WS) <Int 1013
endmodule

