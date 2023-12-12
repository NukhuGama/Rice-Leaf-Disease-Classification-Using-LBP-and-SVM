function [ LBPHistogram ] = LBP_U( OrgIm,DoUniform)% if DoUniform = true -> return hisogram of 10 bin,  if DoUniform = false -> return hisogram of 256 bin

Row=size(OrgIm,1);
Col=size(OrgIm,2);

for i=2:Row-1
    for j=2:Col-1
        Uniform = true;
        MidPixelValue=OrgIm(i,j);
        EncodedVec(1)=OrgIm(i-1,j-1)>MidPixelValue;
        EncodedVec(2)=OrgIm(i-1,j)>MidPixelValue;
        EncodedVec(3)=OrgIm(i-1,j+1)>MidPixelValue;
        EncodedVec(4)=OrgIm(i,j+1)>MidPixelValue;
        EncodedVec(5)=OrgIm(i+1,j+1)>MidPixelValue;
        EncodedVec(6)=OrgIm(i+1,j)>MidPixelValue;
        EncodedVec(7)=OrgIm(i+1,j-1)>MidPixelValue;
        EncodedVec(8)=OrgIm(i,j-1)>MidPixelValue;
        EncodedVecShift = circshift(EncodedVec,[0,1]);
        if DoUniform
            if sum(xor(EncodedVec,EncodedVecShift)) > 2 % more than 2 transition of 0 -> 1
                Uniform = false;
                LBPImage(i,j)=9;
            end
        end
        if or(Uniform == true  , DoUniform == false) % if LBP not uniform mode , or the texture is uniform -> 8 bits assign
            MinLbp = EncodedVec(1)*2^7+EncodedVec(2)*2^6+EncodedVec(3)*2^5+EncodedVec(4)*2^4+EncodedVec(5)*2^3+EncodedVec(6)*2^2+EncodedVec(7)*2^1+EncodedVec(8)*2^0;
            MinVector = EncodedVec;
            for k = 1 : 7
                EncodedVec = circshift(EncodedVec,[0,1]);
                CurrLbpValue =EncodedVec(1)*2^7+EncodedVec(2)*2^6+EncodedVec(3)*2^5+EncodedVec(4)*2^4+EncodedVec(5)*2^3+EncodedVec(6)*2^2+EncodedVec(7)*2^1+EncodedVec(8)*2^0;
                if CurrLbpValue < MinLbp
                    MinLbp = CurrLbpValue;
                    MinVector = EncodedVec;
                end
            end
            LBPImage(i,j)=MinVector(1)*2^7+MinVector(2)*2^6+MinVector(3)*2^5+MinVector(4)*2^4+MinVector(5)*2^3+MinVector(6)*2^2+MinVector(7)*2^1+MinVector(8)*2^0;
        end
    end
end
if DoUniform
    LBPImage(LBPImage ~=9) = log2(LBPImage(LBPImage ~=9)+1);
    LBPHistogram=zeros(1,10);
    for i =1:size(LBPImage,1)
        for k = 1:size(LBPImage,2)
            LBPHistogram(1,LBPImage(i,k)+1)=LBPHistogram(1,LBPImage(i,k)+1)+1;
        end
    end
else
    LBPHistogram=zeros(1,256);
    for i =1:size(LBPImage,1)
        for k = 1:size(LBPImage,2)
            LBPHistogram(1,LBPImage(i,k)+1)=LBPHistogram(1,LBPImage(i,k)+1)+1;
        end
    end
end

end