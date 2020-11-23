function Q = influx(t)
  if t >= 0 && t < 20
    Q = 110;
  elseif t >= 20 && t < 40
    Q = 100;
  elseif t >= 40 && t < 80
    Q = 95;
  elseif t >= 80 && t <= 100
    Q = 100;
  end
end
