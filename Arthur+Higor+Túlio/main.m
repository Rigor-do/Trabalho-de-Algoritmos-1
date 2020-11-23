% Trabalho 1 da matéria de Algoritmos Númericos para Engenharia feito em Octave.
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

pause(0.1); % Espera pela inclusão da symbolic antes de dar o print da solução 1 - não funciona da forma que esperava kk

% Chamando resolução da letra A
fprintf("------ Solucao 2.A ------\n");
Solve2A

% Chamando resolução da letra B
fprintf("\n------ Solucao 2.B ------\n");
Solve2B

% Chamando resolução da letra C
fprintf("\n------ Solucao 2.A ------\n");
Solve2C

% Chamando resolução da 3
fprintf("\n------ Solucao 3 ------\n");
Solve3

fprintf("------ Programa finalizado ------\n");