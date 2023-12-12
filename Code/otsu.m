function [ambang] = otsu(F)
% Memperoleh nilai ambang menggunakan metode Otsu
%    F = Citra berskala keabuan

[m, n] = size(F);
jum_piksel = m * n;

% Kosongkan histogram
for i=1 : 256
    h(i) = 0;
end

% Hitung histogram
for i=1 : m
    for j=1 : n
        intensitas = F(i,j);
        h(intensitas+1) = h(intensitas+1) + 1;
    end
end

% Hitung p(i)
for i=1 : 256
    p(i) = h(i) / jum_piksel;
end

% Hitung rerata total
mT = 0;
for i=1 : 256
    mT = mT + i * p(i);
end

% Hitung t optimal
ambang = 0;
varMaks = 0;
for t=0 : 255
    % Hitung w1(t)
    w1 = 0.0;
    for i=1 : t
        w1 = w1 + p(i+1);
    end
    
    % Hitung w2(t)
    w2 = 0.0;
    for i=t+1 : 255
        w2 = w2 + p(i+1);
    end
    
    % Hitung m1
    m1 = 0;
    for i=0 : t
        if w1 > 0
           m1 = m1 + i * p(i+1)/w1;
        end
    end
    
    % Hitung m2
    m2 = 0;
    for i=t+1 : 255
        if w2 > 0
           m2 = m2 + i * p(i+1)/w2;
        end
    end
    
    % Hitung BCV
    bcv = w1 * (m1 - mT)^2 + w2 * (m2 - mT)^2;
   
    if bcv > varMaks
        varMaks = bcv;
        ambang = t;
    end
end