% Saint Petersburg Electrotechnical University, Saint Petersburg, Russia
% Faculty of Radio Engineering
% Department of Theoretical Fundamentals of Radio Engineering
% Alexander B. Sergienko, 2015

function y = log_sum_exp(x)
xm = max(x);
x = x-repmat(xm, size(x,1), 1);
y = xm + log(sum(exp(x)));
