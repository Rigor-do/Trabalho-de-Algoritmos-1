% Trabalho 1 da matéria de Algoritmos Númericos para Engenharia. 
% O trabalho é uma impletementação de diferentes métodos de resolução de EDO, entre eles Euler e Runge-Kutta.
% Usando Symbolic v2.9.0 e SymPy v1.5.1.
% Por Arthur Sorrentino, Higor Oliveira, Tulío Brunoro

clear all; % Limpeza do ambiente
close all hidden

addpath(['../' 'util'], ['../' 'edo']);%% --------- resolver problema e depois reinserir o tempo
pkg load symbolic;	% Carregar bibliotéca simbólica
available_graphics_toolkits(); % Adiciona um pacote de alteração do gráfico
graphics_toolkit gnuplot;

% Declaração das variáveis simbólicas
syms y(x)

% ---------------------------------------------------------- 1 ----------------------------------------------------------
ode = diff(y, x) == -y; % Definição da função
x0 = 0; y0 = 1; % Definição do PVI
cond = y(x0) == y0; % Definição do ponto para o symbolic
func = @(x,y) -y; % Definição da função para o Octave
edostr = 'EDO: dy/dx = -y(x) - Valor inicial: y(0) = 1 -- Sol: y(x) = exp(-x)'; % String aleatoria do título do gráf.

fprintf('EDO para symbolic: '); ode % Printa a EDO para o symbolic
fprintf('Condicao inicicial para symbolic: '); cond % Printa o PVI para o symbolic

sol = dsolve(ode, cond); % Resolve analiticamente
fprintf('Solucao: '); sol
if iscell(sol)
	sol = sol{1};
else
	sol = sol;
end % Captura a solução caso dsolve retorne mais argumentos

% ---------------------------------------------------------- 2 ----------------------------------------------------------
F = rhs(sol); % Pega lado direito da equação 
yx = matlabFunction(F); % Cria o equivalente não-simbolico para o Octave
fprintf('Versao numerica da solucao: '); yx % Printa a solução numérica

% ---------------------------------------------------------- 3 ----------------------------------------------------------
n = 10; h = 1/10; xn = x0+n*h;% Definição do número de interações de cada método e passos
x = x0:h/10:xn; % Pontos do gráfico em x;

figure(1, 'name', "Solucao analitica + solucoes iterativas")
plot(x,yx(x),'-k');
hold on
% axis([-1 3 -1 5]);
leg = {'Sol. Analitica: y(x)'};
leg2 = {'S.Anali.'};
title(edostr);
legend(leg);
shg;

Y0 = yx(x0:h:xn);

% ---------------------------------------------------------- 4 ----------------------------------------------------------

% --- Euler
[X1,Y1] = Euler(func, x0, y0, h, n);
plot(X1, Y1, 'co')
leg{end+1} = 'Euler';
leg2{end+1} = 'Euler';

% --- Euler Melhorado
[X2,Y2] = EulerMelhorado(func, x0, y0, h, n);
plot(X2, Y2, 'yo')
leg{end+1} = 'Euler Melhorado';
leg2{end+1} = 'Euler Mel.';

% --- Modificado
[X3,Y3] = EulerModificado(func, x0, y0, h, n);
plot(X3, Y3, 'go')
leg{end+1} = 'Euler Modificado';
leg2{end+1} = 'Euler Mod.';

% --- genérico de 2° Ordem com alfa = 1/3
alfa1 = 1/3;
[X4,Y4] = RungeKutta_GenericoSegundaOrdem(func, x0, y0, h, n, alfa1);
plot(X4, Y4, 'm^')
leg{end+1} = 'Generico de 2 ordem com alfa = 1/3';
leg2{end+1} = '2ord a=1/3';

% --- genérico de 2° Ordem com alfa = 1/4
alfa2 = 1/4;
[X5,Y5] = RungeKutta_GenericoSegundaOrdem(func, x0, y0, h, n, alfa2);
plot(X5, Y5, 'g^')
leg{end+1} = 'Generico de 2 ordem com alfa = 1/4';
leg2{end+1} = '2ord a=1/4';

% --- Dormand-Prince com passo fixo
[X6,Y6] = RungeKutta_Dormand_Prince_ode45(func, x0, y0, h, n, 1);
plot(X6, Y6, 'r*')
leg{end+1} = 'Dormand-Prince com passo fixo';
leg2{end+1} = 'Ode45 fixo';

% --- Dormand-Prince com passo adaptativo
[X7,Y7] = RungeKutta_Dormand_Prince_ode45(func, x0, y0, h, n, 0);
plot(X7, Y7, 'k*')
leg{end+1} = 'Dormand-Prince com passo adaptativo';
leg2{end+1} = 'Ode45 Adap.';

legend(leg);
shg;


%%% parei na tentativa de plotar A
A = zeros(12,8);
B = zeros(11,8);
B = [Y0' Y1' Y2' Y3' Y4' Y5' Y6' Y7(1:11)'];
% vecA = zeros(12,1);
% vecA(1,1) =  leg2(1);
% vecA(1,2:) = Y0';
A = [leg2; 
	Y0' Y1' Y2' Y3' Y4' Y5' Y6' Y7(1:11)'];
% printTabXY( X1, 'X', Y1, 'Y', fmt, 'Euler' );
% printTabXY( x, 'X', fx-Y, 'Erro', fmt, 'ERRO: Euler' );
% printTabXY( X, 'X', Y, 'Y', fmt, 'Euler Melhorado' );
% printTabXY( x, 'X', fx-Y, 'Erro', fmt, 'ERRO: Euler Melhorado' );
% printTabXY( X, 'X', Y, 'Y', fmt, 'Euler Modificado' );
% printTabXY( x, 'X', fx-Y, 'Erro', fmt, 'ERRO: Euler Modificado' );

%figure(2,'name', 'Erros');
