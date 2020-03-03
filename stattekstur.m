function [Stat] = stattekstur(F)
% STATTEKSTUR Memperoleh statistik tekstur.
%     Masukan: F = citra berskala keabuan.
%     Keluaran: Stat = berisi statistik tekstur
%
%     Didasarkan pada Gonzalez, Woods, dan Eddins, 2004

[m, n, dim] = size(F);

% Hitung frekuensi aras keabuan
L = 256;
Frek = zeros(L,1);
F = double(F);
for i = 1 : m
    for j = 1 : n
        intensitas = F(i,j); 
       
        Frek(intensitas+1) = Frek(intensitas+1) + 1;
    end
end

% Hitung probabilitas
jum_piksel = m * n;
for i=0 : L-1
    Prob(i+1) = Frek(i+1) / jum_piksel;
end

% Hitung mu
mu = 0;
for i=0 : L-1
    mu = mu + i * Prob(i+1);    
end

% Hitung deviasi standar
varians = 0;
for i=0 : L-1
   varians = varians + (i - mu)^2 * Prob(i+1);    
end

deviasi = sqrt(varians);
varians_n = varians / (L-1)^2; % Normalisasi

% Hitung skewness
skewness = 0;
for i=0 : L-1
   skewness = skewness + (i - mu)^3 * Prob(i+1);    
end

skewness = skewness / (L-1)^2;

% Energi (Keseragaman)
energi = 0;
for i=0 : L-1
   energi = energi + Prob(i+1)^2;    
end

% Entropi
entropi = 0;
for i=0 : L-1
   if Prob(i+1) ~= 0 
       entropi = entropi + Prob(i+1) * log(Prob(i+1));        
   end
end

entropi = -entropi;

% Hitung R atau Smoothness
smoothness = 1 - 1 / (1 + varians_n);
RMS = mean2(rms(F));
% Inverse Difference Movement
% in_diff = 0;
% for i = 1:m
%     for j = 1:n
%         temp = F(i,j)./(1+(i-j).^2);
%         in_diff = in_diff+temp;
%     end
% end
% IDM = double(in_diff);

Stat.mu = mu;
Stat.deviasi = deviasi;
Stat.skewness = skewness;
Stat.energi = energi;
Stat.entropi = entropi;
Stat.smoothness = smoothness;
Stat.RMS = RMS;
% Stat.IDM = IDM;