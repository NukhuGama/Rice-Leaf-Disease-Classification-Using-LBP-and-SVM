function G = erosi(F, H, hotx, hoty)

    [th, lh] = size(H);
    [tf, lf] = size(F);
    
    if nargin < 3
        hotx = round(lh/2);
        hoty = round(th/2);
    end;
    
    Xh = [];
    Yh = [];
    jum_anggota = 0;
    
    % Menentukan koordinat piksel bernilai i pada H
    for baris=1:th
        for kolom=1:lh
            if H(baris,kolom)==1
                jum_anggota = jum_anggota + 1;
                Xh(jum_anggota) = -hotx + kolom;
                Yh(jum_anggota) = -hoty + baris;
            end;
        end;
    end;
    % Nolkan semua pada hasil erosi
    G = zeros(tf,lf); 
    % Memproses erosi
    for baris=1:tf
        for kolom=1:lf
            cocok = true;
            for indeks=1:jum_anggota
                xpos = kolom + Xh(indeks);
                ypos = baris + Yh(indeks);
                
                if (xpos>=1) && (xpos<=lf) && (ypos>=1) && (ypos<=tf)
                    if F(ypos, xpos) ~= 1
                        cocok = false;
                        break;
                    end;
                else
                    cocok = false;
                end;
                
            end;
            if cocok
                G(baris, kolom) = 1;
            end;
        end;
    end;
    
