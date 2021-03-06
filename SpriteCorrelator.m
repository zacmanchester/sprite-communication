function maxCor = SpriteCorrelator(baseband,prn,sps)

if size(baseband, 2) > size(baseband, 1)
    baseband = baseband.';
end

bbTemplate = cc430modulator(2*prn-1,sps);

steps = length(baseband)-length(bbTemplate);

maxCor = zeros(steps,1);
for k = 1:steps
    pw = conj(bbTemplate).*baseband(k:k+length(bbTemplate)-1);
    ft = fft(pw);
    maxCor(k) = max(abs(ft));
end

end
