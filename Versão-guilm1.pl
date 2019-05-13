principal:- open('c:/users/adriana/desktop/disciplinas19.1/linguagens/game_prolog_lp/casas.txt',read,F),
    read(F,C1),
    read(F,C2),
    read(F,C3),
    read(F,C4),
    read(F,C5),
    close(F),
    write([C1,C2,C3,C4,C5]), nl, aux.
% Teste de leitura e escrita no fim do arquivo
aux :- open('c:/users/adriana/desktop/disciplinas19.1/linguagens/game_prolog_lp/casas.txt', append,G),
    write(G,'\nteste.'),
    close(G),
    nl.
