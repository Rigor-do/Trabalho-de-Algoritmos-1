t0 = 0;
v0 = 500;
h = 1;
n = 100;

function retorno = f(t)
  retorno = influx(t) - outflux(t) - vazamento(t);
end

T = zeros(1, n);
V = zeros(1, n);
influxs = zeros(1, n);
outfluxs = zeros(1, n);
vazamentos = zeros(1, n);
etas = zeros(1, n);

t = t0; v = v0;
T(1) = t; V(1) = v;
influxs(1) = influx(1);
outfluxs(1) = outflux(1);
vazamentos(1) = vazamento(1);
etas(1) = rand() * 6 - 3;
Q(1) = f(1);

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

printTabXY( T, 'T', V, 'V', '%.5e', 'Euler' );

figure('name', 'Gilberto');

hold on;
legends = {};
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

xlabel("t[h]");
ylabel("Fluxo [Q(m^3/h)] ----- Volume [m^3]");
legend(legends, "location", "northeast");

fprintf("Pausando por 0,5 seg para processar os graficos\n");
pause(0.5);