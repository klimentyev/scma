% Saint Petersburg Electrotechnical University, Saint Petersburg, Russia
% Faculty of Radio Engineering
% Department of Theoretical Fundamentals of Radio Engineering
% Vyacheslav P. Klimentyev and Alexander B. Sergienko, 2015

function y = scmaenc(x, CB, h)
%  SCMA encoder
%
%  K - number of orthogonal resources
%  V - number of users (layers)
%  M - number of codewords in each codebook
%
%  N - frame size
%
%  Input arguments:
%
%  x   - input signal (matrix of symbols that range from 0 to M-1, size VxN)
%  CB  - SCMA codebooks (size KxMxJ)
%  h   - channel coefficients (size KxJxN)
%
%  Output arguments:
%
%  y   - SCMA signal after fading channel (size KxN)

K = size(CB, 1);
V = size(CB, 3);

N = size(x, 2);
y = zeros(K, N);

for n = 1:N
    for k = 1:V
        y(:,n) = y(:,n)+CB(:, x(k,n)+1, k).*h(:,k,n);
    end
end
end
