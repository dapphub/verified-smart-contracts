requires "edsl.k"
requires "../lemmas.k"

module VERIFICATION
    imports EDSL
    imports LEMMAS

    rule (X *Int Y) *Int (Y ^Int (N -Int 1))
          => X *Int (Y ^Int N)

    rule A *Int C <=Int C *Int (A ^Int B) => true
      requires B >Int 0

    rule C *Int (A ^Int B) => C
      requires B ==Int 0

    rule C *Int (A ^Int B) => C *Int A
      requires B ==Int 1

    rule chop(A *Int C) => C *Int A
      requires C *Int (A ^Int B) <Int pow256

endmodule
