requires "edsl.k"
requires "../lemmas.k"

module VERIFICATION
    imports EDSL
    imports LEMMAS

rule C *Int A <=Int C *Int (A ^Int B) => true requires B >Int 0

rule C *Int A ^Int B => C requires B ==Int 0

rule (X *Int Y) *Int (Y ^Int (N -Int 1)) => X *Int (Y ^Int N)

endmodule
