function [G] = ambang(F, t)                                                                                               
% Menentukan nilai ambang yang digunakan
%     untuk melakukan pengambangan
%     F = Citra berskala keabuan
%     t = nilai ambang
%
% Keluaran: G = Citra biner

[m, n] = size(F);
for i=1 : m
    for j=1:n
        if F(i,j) <= t
            G(i,j) = 0;
        else
            G(i,j) = 1;
        end
    end
end
