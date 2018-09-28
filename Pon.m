function P = Pon(P1, n, k)

P = (factorial(n)/(factorial(k)*factorial(n-k)))*P1^k*(1-P1)^(n-k);

end

