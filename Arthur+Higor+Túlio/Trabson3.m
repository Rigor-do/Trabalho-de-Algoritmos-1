clear all;
pkg load symbolic;

% Declaração das variáveis simbólicas
syms y(x)

% func = @(x,y) y;
edostr = 'EDO: dy/dx = y(x) Valor inicial: y(0)=1 --- Solução: y(x) = exp(x)';
x0 = 0; y0 = 1;
ode = diff(y, x) == y*(x^2 - 1);

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

x = 0:0.01:2;

clf
plot(x,yx(x));
% axis([-1 3 -1 5]);
leg = {'y(x)'};
title(edostr);
legend(leg);

shg;