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

pause(0.1); % Espera pela inclusão da symbolic antes de dar o print da solução 1

% Chamando resolução da letra A
fprintf("------ Solucao 2.A ------\n");
Solve2A

% Chamando resolução da letra B
fprintf("------ Solucao 2.B ------\n");
Solve2B

% Chamando resolução da letra C
fprintf("------ Solucao 2.A ------\n");
Solve2C

fprintf("------ Programa finalizado ------\n");