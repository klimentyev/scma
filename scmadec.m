% Saint Petersburg Electrotechnical University, Saint Petersburg, Russia
% Faculty of Radio Engineering
% Department of Theoretical Fundamentals of Radio Engineering
% Vyacheslav P. Klimentyev and Alexander B. Sergienko, 2015

function LLR = scmadec(y, CB, h, N0, Nit)
%  SCMA decoder (Log-MPA)
%
%  K - number of orthogonal resources
%  V - number of users (layers)
%  M - number of codewords in each codebook
%
%  N - frame size
%
%  Input arguments:
%
%  y   - SCMA signal after fading channel (size KxN)
%  CB  - SCMA codebooks (size KxMxJ)
%  h   - channel coefficients (size KxJxN)
%  N0  - variance of noise (in AWGN channel)
%  Nit - number of MPA iterations
%
%  Output arguments:
%
%  LLR - Log-Likelihood Ratio (size (log2(M)*V)xN)

K = size(CB, 1);
M = size(CB, 2);
V = size(CB, 3);

% Factor graph calculation
F = zeros(K, V);
s = [K, M];
for k = 1:V
    IND = find(CB(:,:,k));
    [I, ~] = ind2sub(s, IND);
    F(unique(I),k) = 1;
end

N   = size(y, 2);
LLR = zeros(log2(M)*V, N);

Noise = 1/N0;

parfor jj = 1:N

    % Step 1: Initial calculations
    f = zeros(M, M, M, K);

    for k = 1:K % resourses
        ind = find(F(k,:)==1); % non-zero elements, paths
        for m1 = 1:M
            for m2 = 1:M
                for m3 = 1:M
                    d = y(k,jj)-(CB(k,m1,ind(1))*h(k,ind(1),jj)+CB(k,m2,ind(2))*h(k,ind(2),jj)+CB(k,m3,ind(3))*h(k,ind(3),jj));
                    f(m1,m2,m3,k) = -Noise*sum(real(d)^2+imag(d)^2);
                end
            end
        end
    end

    Ap  = log(1/M);
    Igv = zeros(K, V, M);
    Ivg = Ap*ones(K, V, M);

% Step 2: Iterative procedure
    for iter = 1:Nit
        % Igv update
        for k = 1:K
            ind = find(F(k,:)==1);

            for m1 = 1:M
                sIgv = zeros(1, M*M);
                for m2 = 1:M
                    for m3 = 1:M
                        sIgv((m2-1)*M+m3) = f(m1,m2,m3,k)+Ivg(k,ind(2),m2)+Ivg(k,ind(3),m3);
                    end
                end
                Igv(k,ind(1),m1) = log_sum_exp(sIgv);
            end

            for m2 = 1:M
                sIgv = zeros(1, M*M);
                for m1 = 1:M
                    for m3 = 1:M
                        sIgv((m1-1)*M+m3) = f(m1,m2,m3,k)+Ivg(k,ind(1),m1)+Ivg(k,ind(3),m3);
                    end
                end
                Igv(k,ind(2),m2) = log_sum_exp(sIgv);
            end

            for m3 = 1:M
                sIgv = zeros(1, M*M);
                for m1 = 1:M
                    for m2 = 1:M
                        sIgv((m1-1)*M+m2) = f(m1,m2,m3,k)+Ivg(k,ind(1),m1)+Ivg(k,ind(2),m2);
                    end
                end
                Igv(k,ind(3),m3) = log_sum_exp(sIgv);
            end
        end

        % Ivg update
        for k = 1:V
            ind = find(F(:,k)==1);
            s1 = log(sum(exp(Igv(ind(1),k,:))));
            s2 = log(sum(exp(Igv(ind(2),k,:))));
            for n = 1:M
                % analogue of normalization in MPA, it can be removed (s1 and s2), but at high SNR and/or number of iterations NaN LLR values can be exist, so Max-Log-MPA is required
                Ivg(ind(1),k,n) = Igv(ind(2),k,n)-s2;
                Ivg(ind(2),k,n) = Igv(ind(1),k,n)-s1;
            end
        end

    end

% Step 3: LLR calculation
    Q = zeros(M, V);
    for k = 1:V
        ind = find(F(:,k)==1);
        for m = 1:M
            Q(m,k) = Ap+Igv(ind(1),k,m)+Igv(ind(2),k,m);
        end
    end

    LLR_tmp = zeros(log2(M)*V, 1); % temp variable for parallel work

    for k = 1:V
        LLR_tmp(2*k-1) = log((exp(Q(1,k))+exp(Q(2,k)))/((exp(Q(3,k))+exp(Q(4,k)))));
        LLR_tmp(2*k)   = log((exp(Q(1,k))+exp(Q(3,k)))/((exp(Q(2,k))+exp(Q(4,k)))));
    end
    LLR(:,jj) = LLR_tmp;
end
