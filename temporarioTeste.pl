% Gerar Matriz de 1 e conseguir imprimir em um arquivo
% Para Fins de Teste Lembre-se de colocar o caminho da Path
geraMatriz(0, _, []) :- !.
geraMatriz(N, M, [K|Ks]) :- open('c:/users/adriana/desktop/disciplinas19.1/linguagens/game_prolog_lp/matriz.txt',append,F),
                            N1 is N - 1,
                            write(F,'|'), write('|'), close(F),
                            geraVetor(M, K), open('c:/users/adriana/desktop/disciplinas19.1/linguagens/game_prolog_lp/matriz.txt',append,H),
                            write(H,'|'), write('|'),
                            write(H, '\n'), write('\n'), close(H),
                            geraMatriz(N1, M, Ks),espaco.
espaco :- open('c:/users/adriana/desktop/disciplinas19.1/linguagens/game_prolog_lp/matriz.txt',append,F),
          write(F,'\n'),
          close(F).
geraVetor(0, []) :- !.
geraVetor(M, [1|Ks]) :- open('c:/users/adriana/desktop/disciplinas19.1/linguagens/game_prolog_lp/matriz.txt',append,G),
                        M1 is M - 1,
                        write(G,' 1 '), write(' 1 '),
                        geraVetor(M1, Ks), close(G).


principal(M):- open('c:/users/adriana/desktop/disciplinas19.1/linguagens/game_prolog_lp/matriz.txt',append,F),
               write(F, M),
               close(F).
