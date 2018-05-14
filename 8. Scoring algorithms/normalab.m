function y = normalab(x,a,b)
    y=a+(x-min(x))*(b-a)/(max(x)-min(x));