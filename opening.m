function G = opening (F, H)
% OPENING Melakukan operasi opening.

G = dilasi(erosi(F, H), H);