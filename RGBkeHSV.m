function [H,S,V] = RGBkeHSV(R,G,B)
% RGBkeHSV digunakan untuk mengonversi RGB ke HSV.
%    Algoritma berdasarkan Nan C. Schaller
%    (http://www.cs.rit.edu/~ncs/color/t_convert.html)

% Normalisasi RGB ke [0, 1]
R = double(R);
G = double(G);
B = double(B);

if max(max(R)) > 1.0 || max(max(G)) > 1.0 || ...
   max(max(B)) > 1.0
    R = double(R) / 255;
    G = double(G) / 255;
    B = double(B) / 255;
end

[tinggi, lebar] = size(R);
for m=1: tinggi
    for n=1: lebar
        minrgb = min([R(m,n) G(m,n) B(m,n)]); 
        maxrgb = max([R(m,n) G(m,n) B(m,n)]); 
        V(m,n) = maxrgb;
        delta = maxrgb - minrgb;
        if maxrgb == 0
            S(m,n) = 0;
            H(m,n) = 0; 
        else
            S(m,n) = delta / maxrgb;
            if R(m,n) == maxrgb
                % Di antara kuning dan magenta
                H(m,n) = (G(m,n)-B(m,n)) / delta;
            elseif G(m,n) == maxrgb
                % Di antara cyan dan kuning
                H(m,n) = 2 + (B(m,n)-R(m,n)) / delta;
            else
                % Di antara magenta dan cyan
                H(m,n) = 4 + (R(m,n)-G(m,n)) / delta;
            end
            
            H(m,n) = H(m,n) * 60;
            if H(m,n) < 0
                H(m,n) = H(m,n)+360;
            end
        end
    end
end

% Konversikan ke jangkauan [0, 255] atau [0, 360]
H = uint8(H * 255/360);
S = uint8(S * 255);
V = uint8(V * 255);