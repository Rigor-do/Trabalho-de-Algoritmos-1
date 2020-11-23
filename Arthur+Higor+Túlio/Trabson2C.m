% Trabalho 1 da matéria de Algoritmos Númericos para Engenharia. 
% O trabalho é uma impletementação de diferentes métodos de resolução de EDO, entre eles Euler e Runge-Kutta.
% Usando Symbolic v2.9.0 e SymPy v1.5.1. (testado com Symbolic v2.7.0 e SymPy v1.2 também)
% Por Arthur Sorrentino, Higor Oliveira, Tulío Brunoro

close all; % Fecha janelas de plot abertas
clear all; % Limpeza do ambiente
%close all hidden % Limpeza mais detalhada

addpath(['../' 'util'], ['../' 'edo']); % Inserção das funções auxiliares
pkg load symbolic;	% Carregar bibliotéca simbólica
available_graphics_toolkits(); % Adiciona um pacote de alteração do gráfico
graphics_toolkit gnuplot;

% Declaração das variáveis simbólicas
syms y(x)

% ---------------------------------------------------------- 1 ----------------------------------------------------------
ode = diff(y, x) == y*(x^2 - 1); % Definição da função
x0 = 0; y0 = 1; % Definição do PVI
cond = y(x0) == y0; % Definição do ponto para o symbolic
func = @(x,y) y*(x^2 - 1); % Definição da função para o Octave
leggraf = 'EDO: dy/dx = y*(x^2 - 1) - Valor inicial: y(0) = 1 -- Sol: y(x) = 3*sqrt(x*2)/2 + x - 1'; % String aleatoria do título do gráf.

fprintf('EDO para symbolic: '); ode % Printa a EDO para o symbolic
fprintf('Condicao inicicial para symbolic: '); cond % Printa o PVI para o symbolic

sol = dsolve(ode, cond); % Resolve analiticamente
fprintf('Solucao: '); sol % Printa a solução
if iscell(sol)
	sol = sol{1};
else
	sol = sol;
end % Captura a só solução caso dsolve retorne mais argumentos


% fprintf("-------------%d--------------", 1);
% ---------------------------------------------------------- 2 ----------------------------------------------------------
F = rhs(sol); % Pega lado direito da equação 
yx = matlabFunction(F); % Cria o equivalente não-simbolico para o Octave
fprintf('Versao numerica da solucao: '); yx % Printa a solução numérica

% fprintf("-------------%d--------------", 2);
% ---------------------------------------------------------- 3 ----------------------------------------------------------
n = 10; h = 1/10; xn = x0+n*h;% Definição do número de interações de cada método e passos
x = x0:h/10:xn; % Pontos do gráfico em x;

figure('name', "Solucao analitica & solucoes iterativas") % Abre a janela de plot com nome definido
plot(x,yx(x),'-k'); % Plot 1
hold on
leg = {'Sol. Analitica: y(x)'}; % Legenda da janela 1
legtab = {'S.Anali.'}; % Legenda da tabela 2
title(leggraf);
legend(leg);
shg;

Y0 = yx(x0:h:xn); % Calcula valores de Y futuramente usado para calculo do erro

% fprintf("-------------%d--------------", 3);
% ---------------------------------------------------------- 4 ----------------------------------------------------------

% --- Euler
[X1,Y1] = Euler(func, x0, y0, h, n);
plot(X1, Y1, 'co--');
leg{end+1} = 'Euler';
legtab{end+1} = 'Euler';

% --- Euler Melhorado
[X2,Y2] = EulerMelhorado(func, x0, y0, h, n);
plot(X2, Y2, 'yo--');
leg{end+1} = 'Euler Melhorado';
legtab{end+1} = 'Euler Mel.';

% --- Modificado
[X3,Y3] = EulerModificado(func, x0, y0, h, n);
plot(X3, Y3, 'go--');
leg{end+1} = 'Euler Modificado';
legtab{end+1} = 'Euler Mod.';

% --- genérico de 2° Ordem com alfa = 1/3
alfa1 = 1/3;
[X4,Y4] = RungeKutta_GenericoSegundaOrdem(func, x0, y0, h, n, alfa1);
plot(X4, Y4, 'm^--');
leg{end+1} = 'Generico de 2 ordem com alfa = 1/3';
legtab{end+1} = '2ord a=1/3';

% --- genérico de 2° Ordem com alfa = 1/4
alfa2 = 1/4;
[X5,Y5] = RungeKutta_GenericoSegundaOrdem(func, x0, y0, h, n, alfa2);
plot(X5, Y5, 'g^--');
leg{end+1} = 'Generico de 2 ordem com alfa = 1/4';
legtab{end+1} = '2ord a=1/4';

% --- Dormand-Prince com passo fixo
[X6,Y6] = RungeKutta_Dormand_Prince_ode45(func, x0, y0, h, n, 1);
plot(X6, Y6, 'r*--');
leg{end+1} = 'Dormand-Prince com passo fixo';
legtab{end+1} = 'Ode45 fixo';

% --- Dormand-Prince com passo adaptativo
[X7,Y7] = RungeKutta_Dormand_Prince_ode45(func, x0, y0, h, n, 0);
plot(X7, Y7, 'k*--');
hold off;
leg{end+1} = 'Dormand-Prince com passo adaptativo';
legtab{end+1} = 'Ode45 Adap.';

fprintf("Pausando por 0,5 seg \n");
pause(0.5);
% fprintf("-------------%d--------------", 4);
% ---------------------------------------------------------- 5 ----------------------------------------------------------

legend(leg); % Add legenda
%shg; % Plotnow
% fprintf("-------------%d--------------", 5);
% ---------------------------------------------------------- 6 ----------------------------------------------------------

Erros = zeros(11,7); % Matriz com valores de erro de cada método, sol analítca como referência
Erros = [(Y0-Y0)' (Y1-Y0)' (Y2-Y0)' (Y3-Y0)' (Y4-Y0)' (Y5-Y0)' (Y6-Y0)'];
Erros = abs(Erros);

leggraf2 = 'Erros de cada metodo em escala semilog(y)';
figure('name', 'Erros de cada metodo em escala semilog(y)'); % Abre a janela de plot com nome definido

% --- Euler
semilogy(X1(2:11), Erros(2:11,2), 'co--'); % temos que limitar do segundo termo para frente pois o primeiro termo é 0. log de 0 é indefinido
hold on;

% --- Euler Melhorado
semilogy(X2(2:11), Erros(2:11,3), 'bo--');

% --- Modificado
semilogy(X3(2:11), Erros(2:11,4), 'go--');

% --- genérico de 2° Ordem com alfa = 1/3
semilogy(X4(2:11), Erros(2:11,5), 'm^--');

% --- genérico de 2° Ordem com alfa = 1/4
semilogy(X5(2:11), Erros(2:11,6), 'g^--');

% --- Dormand-Prince com passo fixo
semilogy(X6(2:11), Erros(2:11,7), 'r*--');
hold off;

title(leggraf2);
legend(leg(2:7),'Location','east'); % Add legenda, excluindo método de passo adaptativo
%shg; % Plotnow

fprintf("Pausando por 0,5 seg \n");
pause(0.5);
% fprintf("-------------%d--------------", 6);
% ---------------------------------------------------------- 7 ----------------------------------------------------------
A = zeros(11,8); % Matriz com valores de Y de cada método
A = [Y0' Y1' Y2' Y3' Y4' Y5' Y6' Y7(1:11)'];

fprintf("\n");
printTabA(A, legtab, 5, 'Tabela dos resultados de cada metodo'); % imprime a tabela dos resultados;
% fprintf("-------------%d--------------", 7);
% ---------------------------------------------------------- 8 ----------------------------------------------------------

fprintf("\n");
printTabA(Erros(:,2:7), legtab(2:7), 7, 'Tabela dos erros de cada metodo'); % imprime a tabela de erros;

% fprintf("-------------%d--------------", 8);

shg; %Drawnow final

% fprintf("-------------%d--------------", 9);
