requires "abstract-semantics.k"
requires "verification.k"

module EXP-CIRC-SPEC
  imports ETHEREUM-SIMULATION
  imports ABSTRACT-SEMANTICS
  imports VERIFICATION

    rule
    <k> #execute => #execute </k>
    <exit-code> _ </exit-code>
    <mode> NORMAL </mode>
    <schedule> BYZANTIUM </schedule>
    <analysis> .Map </analysis> // not part of evm

    <ethereum>
      <evm>
        <output> _ </output>
	<statusCode> _ => _ </statusCode>	
        <callStack> _ => _ </callStack>
        <interimStates> _ </interimStates>
        <touchedAccounts> _ => _ </touchedAccounts>

        <callState>
          <program> #asMapOpCodes(#dasmOpCodes(#parseByteStack("608060405260043610610041576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063305d5b8f14610046575b600080fd5b34801561005257600080fd5b5061007b6004803603810190808035906020019092919080359060200190929190505050610091565b6040518082815260200191505060405180910390f35b6000806002838115156100a057fe5b061415156100b0578290506100b5565b600190505b6002828115156100c157fe5b0491505b600082141515610112576100d98384610118565b925060006002838115156100e957fe5b061415156100fe576100fb8184610118565b90505b60028281151561010a57fe5b0491506100c5565b92915050565b6000808214806101375750828283850292508281151561013457fe5b04145b151561014257600080fd5b929150505600a165627a7a72305820320428155888d22f640d70f834bd7b7b668afe15093a1d630f19825aaaa69f160029"), BYZANTIUM)) </program> 
          <programBytes> #parseByteStack("608060405260043610610041576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063305d5b8f14610046575b600080fd5b34801561005257600080fd5b5061007b6004803603810190808035906020019092919080359060200190929190505050610091565b6040518082815260200191505060405180910390f35b6000806002838115156100a057fe5b061415156100b0578290506100b5565b600190505b6002828115156100c157fe5b0491505b600082141515610112576100d98384610118565b925060006002838115156100e957fe5b061415156100fe576100fb8184610118565b90505b60028281151561010a57fe5b0491506100c5565b92915050565b6000808214806101375750828283850292508281151561013457fe5b04145b151561014257600080fd5b929150505600a165627a7a72305820320428155888d22f640d70f834bd7b7b668afe15093a1d630f19825aaaa69f160029") </programBytes>

          <id> ACCT_ID </id> // contract owner
          <caller> CALLER_ID </caller> // who called this contract; in the begining, origin // msg.sender

          <callData> _ </callData>

          <callValue> 0 </callValue>
          <wordStack> C : B : A : WS => C *Int A ^Int (2 *Int B) : 0 : _ : WS </wordStack>
          <localMem> .Map </localMem>
          <pc> 197 => 274 </pc>
          <gas> G => _ </gas>
  	  <memoryUsed> MU => _ </memoryUsed>	
          <previousGas> _ => _ </previousGas>

          <static> false </static> // NOTE: non-static call
          <callDepth> CALL_DEPTH </callDepth>
		  
        </callState>

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
    requires MU <Int 100
    andBool #sizeWordStack(WS) <Int 100
    andBool 0 <=Int A
    andBool A <Int pow256
    andBool 0 <=Int B
    andBool B <Int pow256
    andBool 0 <=Int C
    andBool C <Int pow256
    andBool C *Int A ^Int (2 *Int B) <Int pow256
    andBool G >=Int (100000000 *Int C) +Int (100000000 *Int A) +Int 1000000000


endmodule

