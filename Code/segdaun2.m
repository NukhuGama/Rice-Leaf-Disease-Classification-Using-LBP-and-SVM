% segdaun2.m
%
% Contoh segmentasi daun melalui citra biner
function E = segdaun2(RGB)
% RGB = imread('daun.jpg');
[m,n,dim] = size(RGB);

% Konversi ke citra berskala keabuan
for baris=1 : m
    for kolom=1 : n
        r = RGB(baris,kolom,1);
        g = RGB(baris,kolom,2);
        b = RGB(baris,kolom,3);
        kelabu = r * 0.2989 + g * 0.5870 + b * 0.1140;
        A(baris,kolom) = kelabu;
    end
end

% figure(1); imshow(A);

A = double(A);

% Lakukan penghalusan dengan rerata
for baris=2 : m-1
    for kolom=2 : n-1
        jum = A(baris-1, kolom-1)+ ...
              A(baris-1, kolom) + ...
              A(baris-1, kolom-1) + ...
              A(baris, kolom-1) + ...
              A(baris, kolom) + ...
              A(baris, kolom+1) + ...
              A(baris+1, kolom-1) + ...
              A(baris+1, kolom) + ...
              A(baris+1, kolom+1);
         
              B(baris, kolom) = jum/9;
    end
end

B = uint8(B);

% Gunakan pengambangan otsu
t = otsu(B);
t = t + 13;  % Koreksi ambang. Sesuaikan dengan kebutuhan
C = ambang(B, t);

% Lakukan operasi morfologi opening
H = ones(3);
D = opening(C, H);
% figure(2); imshow(C);

% Atur bagian tepi berwarna putih
%   sebagai kompnesasi bagian
%   yang tidak diproses sewaktu
%   melakukan pemerataan nilai
for baris=1 : m
    D(baris,1) = 1;                                         
    D(baris,n) = 1;
end

for kolom=1 : n
    D(1,kolom) = 1;
    D(m,kolom) = 1;
end

% figure(3); imshow(D);

% Kosongkan bagian latarbelakang
% untuk mendapatkan bagian daun
E = RGB;
for baris=1 : m
    for kolom=1 : n
        if D(baris, kolom) == 1
            E(baris,kolom,1) = 0;
            E(baris,kolom,2) = 0;
            E(baris,kolom,3) = 0;
        end
    end
end

% figure(4); imshow(E);
% 
% clear RGB A B C D E H;