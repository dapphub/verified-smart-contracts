requires "abstract-semantics.k"
requires "verification.k"

module EXP-NAIVE-CIRC-SPEC
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
          <program> #asMapOpCodes(#dasmOpCodes(#parseByteStack("0x606060405260043610603f576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680632e4c697f146044575b600080fd5b3415604e57600080fd5b606b60048080359060200190919080359060200190919050506081565b6040518082815260200191505060405180910390f35b6000600190505b600082111560a7576098838260ad565b90508180600190039250506088565b92915050565b60008082148060ca5750828283850292508281151560c757fe5b04145b151560d457600080fd5b929150505600a165627a7a72305820a046c345fda3920ecabd3cf31b45562355cbceaccd711fdc86a1c149af5c145d0029"), BYZANTIUM)) </program> 
          <programBytes> #parseByteStack("0x606060405260043610603f576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680632e4c697f146044575b600080fd5b3415604e57600080fd5b606b60048080359060200190919080359060200190919050506081565b6040518082815260200191505060405180910390f35b6000600190505b600082111560a7576098838260ad565b90508180600190039250506088565b92915050565b60008082148060ca5750828283850292508281151560c757fe5b04145b151560d457600080fd5b929150505600a165627a7a72305820a046c345fda3920ecabd3cf31b45562355cbceaccd711fdc86a1c149af5c145d0029") </programBytes>

          <id> ACCT_ID </id> // contract owner
          <caller> CALLER_ID </caller> // who called this contract; in the begining, origin // msg.sender

          <callData> _ </callData>

          <callValue> 0 </callValue>
          <wordStack> C : B : A : .WordStack => C *Int A ^Int B : 0 : A : .WordStack </wordStack>
//          <wordStack> WS => _ </wordStack>
          <localMem> .Map </localMem>
          <pc> 136 => 167 </pc>
          <gas> G => _ </gas>
  	  <memoryUsed> 0 => _ </memoryUsed>	
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
    requires 0 <=Int A andBool A <Int pow256
    andBool 0 <=Int B andBool B <Int pow256
    andBool A ^Int B <Int pow256
    andBool 0 <=Int C andBool C <Int pow256
    andBool G >=Int 10000000
    andBool 0 <=Int CALL_DEPTH
    andBool CALL_DEPTH <Int 100

endmodule

