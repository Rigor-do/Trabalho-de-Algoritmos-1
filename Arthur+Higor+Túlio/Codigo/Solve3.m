v0 = 500; t0 = 0; % Declaração do PVI
h = 1; % Passo da discretização
n = 100; % Número de passos

function retorno = f(t) % Declaração da função que calcula a parte da variação do fluxo
  retorno = influx(t) - outflux(t) - vazamento(t);
end

% Pré-alocações dos vetores com os dados
V = zeros(1, n);
T = zeros(1, n);
influxs = zeros(1, n);
outfluxs = zeros(1, n);
vazamentos = zeros(1, n);
etas = zeros(1, n);

% Definição dos primeiros termos dos vetores
t = t0; v = v0;
T(1) = t; V(1) = v;
influxs(1) = influx(1);
outfluxs(1) = outflux(1);
vazamentos(1) = vazamento(1);
etas(1) = rand() * 6 - 3;
Q(1) = f(1);

% Calculo de todos os pontos discretos
for i=2:n
  eta = rand() * 6 - 3;
  etas(i) = eta;
  v = v + h * f(t) + eta;

  t = t + h;
  T(i) = t; V(i) = v;
  influxs(i) = influx(t);
  outfluxs(i) = outflux(t);
  vazamentos(i) = vazamento(t);
  Q(i) = f(i);
end

% Print na forma dada de tabela
printTabXY( T, 'T', V, 'V', '%.5e', 'Euler' );

% Abre uma nova janela para o plot
figure('name', 'Gilberto');

hold on;
legends = {};
% Plots
plot(T, V-v0, "k-");
legends(1) = "V-V0";
plot(T, influxs, "g-");
legends(2) = "afluente";
plot(T, outfluxs, "r-");
legends(3) = "efluente";
plot(T, vazamentos, "c-");
legends(4) = "vazamentos";
plot(T, etas, "m-");
legends(5) = "ruidos";
plot(T, Q, "b-");
legends(6) = "Q";

% Aplicação das legendas
xlabel("t[h]");
ylabel("Fluxo [Q(m^3/h)] ----- Volume [m^3]");
legend(legends, "location", "northeast");

fprintf("Pausando por 0,5 seg para processar os graficos\n");
pause(0.5);