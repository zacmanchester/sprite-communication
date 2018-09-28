function softBits = SoftBitDecimator(corOut)

    Decimation = 256;

    softBits = zeros(floor(length(corOut)/Decimation),1);

    for k = 1:length(softBits)
        
        min = 0;
        max = 0;

        for j = (Decimation*(k-1)+1):(Decimation*k)
            
            if(corOut(j) > max)
                max = corOut(j);
            elseif(corOut(j) < min)
                min = corOut(j);
            end
            
        end

        if(max > -min)
            softBits(k) = max;
        else
            softBits(k) = min;
        end
    end

end