function Q = outflux(t)
  if t >= 0 && t < 30
    Q = 100;
  elseif t >= 30 && t < 40
    Q = 95;
  elseif t >= 40 && t < 70
    Q = 105;
  elseif t >= 70 && t <= 100
    Q = 85;
  end
end
