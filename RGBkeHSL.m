function [H,S,L] = RGBkeHSL(R,G,B)
% RGBkeHSL digunakan untuk mengonversi RGB ke HSL.
%    Berdasarkan algoritma Max K. Agoston (2005)

% Normalisasi RGB
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
        
        if maxrgb == minrgb
            S(m,n) = 0;
            H(m,n) = 0; % Cek microsoft
        else
            L(m,n) = (minrgb + maxrgb) / 2;
            d = (maxrgb - minrgb);
            
            if L(m,n) <= 0.5
                S(m,n) = d / (maxrgb + minrgb);
            else
                S(m,n) =  d / (2 - minrgb - maxrgb);
            end
            
            % Tentukan hue
            if R(m,n) == maxrgb
                % Warna antara kuning dan magenta
                H(m,n) = (G(m,n)-B(m,n))/d;
            elseif G(m,n) == maxrgb
                % Warna antara cyan dan kuning
                H(m,n) = 2+(B(m,n)-R(m,n))/d;
            else    
                % warna antara magenta dan cyan
                H(m,n) = 4+(R(m,n)-G(m,n))/d;
            end
            
            H(m,n) = H(m,n) * 60;
            if H(m,n) < 0
                H(m,n) = H(m,n) + 360;
            end
        end
    end
end

% Konversikan ke jangkauan [0, 255] atau [0, 360]
H = uint8(H * 255/360);
S = uint8(S * 255);
L = uint8(L * 255);