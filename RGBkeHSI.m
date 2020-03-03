function [H,S,I] = RGBkeHSI(R,G,B)
% RGBkeHSI digunakan untuk mengonversi RGB ke HSI.

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
        I(m,n) = (R(m,n) + G(m,n) + B(m,n)) / 3.0;
        
        if R(m,n) == G(m,n) && G(m,n) == B(m,n)
            S(m,n) = 0;
            H(m,n) = 0;
        else
            S(m,n) = 1 - 3 * minrgb / ...
                     (R(m,n)+G(m,n)+B(m,n));
                     
            y = (R(m,n)-G(m,n)+R(m,n)-B(m,n))/2;
            x = (R(m,n)-G(m,n))*(R(m,n)-G(m,n)) + ...
                (R(m,n)-B(m,n)) * (G(m,n)-B(m,n)); 
            x = sqrt(x);
            sudut = acos(y/x) * 180/pi;      
            if B(m,n) > G(m,n)
                H(m, n) = 360 - sudut;
            else
                H(m,n) = sudut;
            end
        end
    end
end

% Konversikan ke jangkauan [0, 255]
H = uint8(H * 255/360);
S = uint8(S * 255);
I = uint8(I * 255);