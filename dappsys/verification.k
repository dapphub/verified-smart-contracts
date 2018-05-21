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
      requires B >Int 0
      andBool A >=Int 0

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
//	 andBool B >Int 0

    rule C *Int 0 ^Int (2 *Int (B /Int 2)) =>
    	 C *Int 0 ^Int (2 *Int B)
//	 requires B %Int 2 ==Int 0

    rule C *Int (A *Int A) ^Int (2 *Int (B /Int 2)) =>
    	 C *Int A ^Int (2 *Int B)
	 requires B %Int 2 ==Int 0

    rule 0 *Int 0 ^Int (2 *Int (B /Int 2)) =>
    	 0 *Int 0 ^Int (2 *Int B)
	 requires B %Int 2 =/=Int 0

//    rule A <=Int pow256
//    	 => A *Int A <=Int pow256

//    rule 0 <=Int B => 0 <=Int B /Int 2

    rule C *Int (A *Int A) ^Int (2 *Int (B /Int 2)) =>
    	 C *Int A ^Int (2 *Int B)
	 requires B %Int 2 ==Int 0

    rule A *Int A <Int pow256 => true
    	 requires C *Int A ^Int (2 *Int B) <Int pow256
//     	 requires 0 <=Int B
//     	 andBool notBool B ==K
//     	 andBool 1 <=Int C

    rule chop ( A *Int A ) => A *Int A
    requires C *Int A ^Int (2 *Int B) <Int pow256

    rule bool2Word( FORM:Bool ) ==Int 0 => notBool FORM

    // rule chop ( A *Int A ) => A *Int A
    // 	 requires C *Int A ^Int (2 *Int B) <Int pow256
    // 	 andBool 1 <=Int C
    // 	 andBool 0 <=Int B
    // 	 andBool notBool B ==K 0

    rule C *Int A ^Int ( 2 *Int B ) <Int pow256 =>
    	 C *Int (A *Int A) ^Int (B /Int 2) <Int pow256
	 requires B modInt 2 ==Int 0

    rule C *Int A ^Int ( 2 *Int B ) <Int pow256 =>
    	 C *Int (A *Int A) *Int (A *Int A) ^Int (B /Int 2) <Int pow256
	 requires notBool (B modInt 2 ==Int 0)

	 
endmodule
