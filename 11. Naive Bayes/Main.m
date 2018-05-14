clc, clear all;

fprintf('Naive Bayes - Datos Discretos');fprintf('\n')
type='dscr';
prs=0.8;
[P, tY, pc]=nbayes(type,prs);
    
    fprintf('\n');
    fmt = 'Porcentaje de coincidencia %6.1f%% \n';
    fprintf(fmt, pc);
    fprintf('\n');fprintf('\n');
    fprintf('Comparacion de Resultados');fprintf('\n')
    fprintf(repmat('*',1,125),'\n');fprintf('\n');
    disp(P);
    fprintf(repmat('-',1,125),'\n');fprintf('\n');
    disp(tY');
    fprintf(repmat('*',1,125),'\n');fprintf('\n');

fprintf('Naive Bayes - Datos Continuos');fprintf('\n')
type='ct';
prs=0.96;
[P, tY, pc]=nbayes(type,prs);
   
    fprintf('\n');
    fmt = 'Porcentaje de coincidencia %6.1f%% \n';
    fprintf(fmt, pc);

    fprintf('\n');
    fprintf('Comparacion de Resultados');fprintf('\n')
    fprintf(repmat('*',1,125),'\n');fprintf('\n');
    disp(P);
    fprintf(repmat('-',1,125),'\n');fprintf('\n');
    disp(tY');
    fprintf(repmat('*',1,125),'\n');fprintf('\n');
    fprintf('\n');fprintf('\n');

