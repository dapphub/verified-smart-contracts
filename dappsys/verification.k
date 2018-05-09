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

    rule C *Int (A ^Int B) <Int pow256 => A *Int C <Int pow256//6

    rule 0 <=Int (A *Int C) *Int (A ^Int (B -Int 1)) => true // 7
      requires 0 <=Int (C *Int (A ^Int B))

    rule (A *Int (A *Int C)) <Int pow256 => true             // 8
      requires (C *Int (A ^Int B)) <Int pow256
      andBool B >Int 0

endmodule
