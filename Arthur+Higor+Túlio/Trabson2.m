clear all;
pkg load symbolic;

% Declaração das variáveis simbólicas
syms y(x)

% func = @(x,y) y;
x0 = 2; y0 = 4;
ode = diff(y, x) == (x+y+1)/(2*x);
edostr = 'EDO: dy/dx = (x+y(x)+1)/(2*x); Valor inicial: y(2) = 4 --- Solução: y(x) = 3*sqrt(2*x)/2 + x - 1;

fprintf('EDO: '); ode

cond = y(x0)==y0;
fprintf('Condicao inicicial: '); cond

sol = dsolve(ode, cond);
fprintf('Solucao: '); sol

if iscell(sol)
	sol = sol{1};
else
	sol = sol;
end

F = rhs(sol);
yx = matlabFunction(F);
fprintf('Versao numerica da solucao: '); yx

x = 0:0.01:10;

clf
plot(x,yx(x));
% axis([-1 3 -1 5]);
leg = {'y(x)'};
title(edostr);
legend(leg);

shg;