requires "edsl.k"
requires "../lemmas.k"

module VERIFICATION
    imports EDSL
    imports LEMMAS

//These first 8 lemmas are for naive-circ

    rule (A *Int C) *Int (A ^Int (B -Int 1))                 // 1
          => C *Int (A ^Int B)

    rule A *Int C <=Int C *Int (A ^Int B) => true            // 2
      requires B >Int 0

    rule A ^Int B => 1                                       // 3
      requires B ==Int 0

    rule A ^Int B => A                                       // 4
      requires B ==Int 1

    rule A *Int C /Int C => A                                // 5

    rule C *Int (A ^Int B) <Int pow256 => A *Int C <Int pow256//6

    rule 0 <=Int (A *Int C) *Int (A ^Int (B -Int 1)) => true // 7
      requires 0 <=Int (C *Int (A ^Int B))

    rule (A *Int (A *Int C)) <Int pow256 => true             // 8
      requires (C *Int (A ^Int B)) <Int pow256
      andBool B >Int 0

//These next ones are for exp-circ (by squaring)
//B is odd, integer division is flooring:
    rule C *Int (A *Int A) *Int (A *Int A) ^Int (2 *Int (B /Int 2)) =>
    	 C *Int A ^Int (2 *Int B)
	 requires B %Int 2 =/=Int 0
	 andBool B >Int 0

    rule C *Int (A *Int A) ^Int (2 *Int (B /Int 2)) =>
    	 C *Int A ^Int (2 *Int B)
	 requires B%Int 2 ==Int 0

    rule C *Int A ^Int (2 *Int B) <Int pow256 =>
    	 A *Int A <Int pow256
	 requires B >Int 0
	 andBool C >Int 0


    rule C *Int A ^Int (2 *Int B) <Int pow256 =>
    	 C *Int (A *Int A) <Int pow256
	 requires B >Int 0
	 
endmodule
