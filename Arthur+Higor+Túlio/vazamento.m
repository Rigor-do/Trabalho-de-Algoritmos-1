function vazamento = vazamento(t) 
  if 50 - t >= 0
    teta = 0;
  else
    teta = 50 - t;
  end

  vazamento = 10 - (10 - 0) * exp(0.05 * teta);
end
