function resultString = SoftDecode(softbits)

BlockCodeGen5;

energies = ones(125,1);

%Use the first half-second of data to get a baseline for the energy threshold
for k = 1:length(energies);
    vec1 = softbits(k:k+43);
    energies(k) = vec1'*vec1;
end

resultString = '';

for k = length(energies)+1:2:(length(softbits)-48)
    
    vec = softbits(k:k+47);
    energy1 = vec(1:44)'*vec(1:44);
    energy2 = vec(3:46)'*vec(3:46);
    energy3 = vec(5:48)'*vec(5:48);
    
    energies(mod(k-1,length(energies))+1) = energy1;
    medE = median(energies);
    
    if energy2 > 10*medE && energy1 < energy2 && energy3 < energy2
        
        odds = vec(1:2:end);
        evens = vec(2:2:end);
        
        codewords = [(odds(1:end-2) + evens(1:end-2))/norm(odds(1:end-2) + evens(1:end-2)),...
                     (odds(1:end-2) + evens(2:end-1))/norm(odds(1:end-2) + evens(2:end-1)),...
                     (odds(2:end-1) + evens(1:end-2))/norm(odds(2:end-1) + evens(1:end-2)),...
                     (odds(2:end-1) + evens(2:end-1))/norm(odds(2:end-1) + evens(2:end-1)),...
                     (odds(3:end) + evens(3:end))/norm(odds(3:end) + evens(3:end)),...
                     (odds(3:end) + evens(2:end-1))/norm(odds(3:end) + evens(2:end-1)),...
                     (odds(2:end-1) + evens(3:end))/norm(odds(2:end-1) + evens(3:end))];
                
        cor = C*codewords/sqrt(22);
        
        [val1, index1] = max(cor);
        [val2, index2] = max(val1);
        val = val2;
        index = index1(index2);
        
        %If the correlation value is low, mark as an erasure
        %if (val < .75)
        %    index = double('_')+1;
        %end
        
        %Debug version
        %resultString = [resultString, '<', num2str(val,'%1.2f'), '>', char(index-1)];
        
        resultString = [resultString, char(index-1)];
        
    end
end

end