requires "abstract-semantics.k"
requires "verification.k"

module LOOP-SPEC
  imports ETHEREUM-SIMULATION
  imports ABSTRACT-SEMANTICS
  imports VERIFICATION

  // loop
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
          <program> #asMapOpCodes(#dasmOpCodes(#parseByteStack("0x608060405260043610610041576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063305d5b8f14610046575b600080fd5b34801561005257600080fd5b5061007b6004803603810190808035906020019092919080359060200190929190505050610091565b6040518082815260200191505060405180910390f35b6000600190505b6000821415156100e55760006002838115156100b057fe5b061415156100c5576100c281846100eb565b90505b6100cf83846100eb565b92506002828115156100dd57fe5b049150610098565b92915050565b60008082148061010a5750828283850292508281151561010757fe5b04145b151561011557600080fd5b929150505600a165627a7a723058207a994f8b4f41bf6910907b26ac55bff5e69963acfdf2ba6a1f07889df76575380029"), BYZANTIUM)) </program>
          <programBytes> #parseByteStack("0x608060405260043610610041576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063305d5b8f14610046575b600080fd5b34801561005257600080fd5b5061007b6004803603810190808035906020019092919080359060200190929190505050610091565b6040518082815260200191505060405180910390f35b6000600190505b6000821415156100e55760006002838115156100b057fe5b061415156100c5576100c281846100eb565b90505b6100cf83846100eb565b92506002828115156100dd57fe5b049150610098565b92915050565b60008082148061010a5750828283850292508281151561010757fe5b04145b151561011557600080fd5b929150505600a165627a7a723058207a994f8b4f41bf6910907b26ac55bff5e69963acfdf2ba6a1f07889df76575380029") </programBytes>

          <id> ACCT_ID </id> // contract owner
          <caller> CALLER_ID </caller> // who called this contract; in the begining, origin // msg.sender

          <callData> _ </callData>

          <callValue> 0 </callValue>
          <wordStack> Z : N : X : WS => Z *Int (X ^Int N) : 0 : _ : WS </wordStack>
          <localMem> _ </localMem>
          <pc> 152 => 229 </pc>
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
            <code> #parseByteStack("0x608060405260043610610041576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063305d5b8f14610046575b600080fd5b34801561005257600080fd5b5061007b6004803603810190808035906020019092919080359060200190929190505050610091565b6040518082815260200191505060405180910390f35b6000600190505b6000821415156100e55760006002838115156100b057fe5b061415156100c5576100c281846100eb565b90505b6100cf83846100eb565b92506002828115156100dd57fe5b049150610098565b92915050565b60008082148061010a5750828283850292508281151561010757fe5b04145b151561011557600080fd5b929150505600a165627a7a723058207a994f8b4f41bf6910907b26ac55bff5e69963acfdf2ba6a1f07889df76575380029") </code>
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
andBool MU ==Int 0
andBool #sizeWordStack(WS) <Int 10
andBool #sizeWordStack(WS) >Int 2
andBool 0 <=Int Z andBool Z <Int pow256
andBool 1 <=Int N andBool N <Int pow256
andBool 1 <=Int X andBool X <Int pow256
andBool 0 <=Int (Z *Int (X ^Int N))
andBool (Z *Int (X ^Int N)) <Int pow256
andBool G >=Int (100000000 *Int N) +Int 1000000000
andBool X ^Int (2 *Int N) <Int pow256




endmodule

