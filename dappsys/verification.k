requires "edsl.k"
requires "../lemmas.k"

module VERIFICATION
    imports EDSL
    imports LEMMAS

    rule (A *Int C) *Int (A ^Int (B -Int 1))                 // 1
          => C *Int (A ^Int B)

    rule A *Int C <=Int C *Int (A ^Int B) => true            // 2
      requires B >Int 0

    rule C *Int (A ^Int B) => C                              // 3
      requires B ==Int 0

    rule C *Int (A ^Int B) => C *Int A                       // 4
      requires B ==Int 1

    rule A *Int C /Int C => A                                // 5
      requires A *Int C <Int pow256

//  rule C *Int (A ^Int B) <Int pow256 => A *Int C <Int pow256//6

    rule 0 <=Int (A *Int C) *Int (A ^Int (B -Int 1)) => true // 7
      requires 0 <=Int (C *Int (A ^Int B))

    rule (A *Int (A *Int C)) <Int pow256 => true             // 8
      requires (C *Int (A ^Int B)) <Int pow256
      andBool B >Int 0

    rule Z *Int (X ^Int N) => Z
      requires N ==Int 0

    rule Z *Int (X ^Int (N %Int 2)) => Z
      requires N ==Int 0

    rule log2Int(N /Int 2) => log2Int(N) -Int 1

    rule (100000000 *Int (log2Int(N))) +Int 1000000000 >Int 0 => true

    rule (X *Int X) <Int pow256 => true
      requires X ^Int (2 *Int N) <Int pow256

    rule 0 ^Int N => 1
      requires N ==Int 0

    rule 0 ^Int N => 0
      requires N >Int 0

    rule Z *Int (X ^Int (N /Int 2)) <Int pow256 ==K true
      requires Z *Int (X ^Int ( N )) <Int pow256 ==K true

endmodule
