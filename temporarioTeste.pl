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
          write(F,'\n'), write('\n'),
          close(F).
geraVetor(0, []) :- !.
geraVetor(M, [1|Ks]) :- open('c:/users/adriana/desktop/disciplinas19.1/linguagens/game_prolog_lp/matriz.txt',append,G),
                        M1 is M - 1,
                        write(G,' 1 '), write(' 1 '),
                        geraVetor(M1, Ks), close(G).


principal(M):- open('c:/users/adriana/desktop/disciplinas19.1/linguagens/game_prolog_lp/matriz.txt',append,F),
               write(F, M),
               close(F).
%-----------Busca pelo Indice--------------------------
busca(0,[X|_], X).

busca(I, [_X|LS], R):-
	I1 is I-1,
	busca(I1, LS, R).

finder(I, J, M, R):-
	busca(I, M, L) ->
	busca(J, L, E), R is E;
	fail.
% -------------------------------------------------------------------
% Passar o elemento da lista que eu quero trocar, a lista e o elemento novo
% swap(Elemento, ETtrocado, Lista, Resposta).

remover(X,[X|C],C).	%  É possível remover um elemento X de uma lista onde
remover(X,[Y|C],[Y|D]):-	%  X é a cabeça.  Se X não é a cabeça da lista, então
remover(X,C,D).   	%  X deve ser removido d corpo da lista.

inserir(X,L,L1):-		%  inserir em função de remover.
remover(X,L1,L).	%  A inserção é sempre feita na cabeça de L.

swap(E, ET, [E|XS], R) :- inserir(ET,XS,R).
swap(E, ET, [X|XS], [X|R]) :- swap(E,ET,XS,R).
%-----------------------------------------------------
% Objetivo: decrementar um elemento específico em uma lista de Lista(Matriz) passando apenas as cordenadas e a matriz
% Usa a ideia do predicaro finder agregado a ideia do predicado Swap
% L = Linha; C = Coluna; M = Matriz; R=Resposta
% Testes:   troca(2,2,[[1,2,3],[4,5,6],[7,8,9]],R).
% Testes:  troca(0,0,[[1,2,3],[4,5,6],[7,8,9]],R).
% Testes: troca(0,1,[[1,2,3],[4,5,6],[7,8,9]],R).

tamLista([_],0).  % retornar quantidade de linhas ou Colunas
tamLista([_|XS],R):- tamLista(XS, A), R is A+1.

printMatriz(-1, _, _) :- !.     % Predicado para printar matriz
printMatriz(L, C, M) :- open('c:/users/adriana/desktop/disciplinas19.1/linguagens/game_prolog_lp/matriz.txt',append,F),
                        write(F, '|'), write('|'),
                        busca(L, M, R1), write(F, R1), write(F, '|\n'),
                        write(R1), write('|\n'),close(F),
                        L1 is L - 1,
                        printMatriz(L1,C,M), espaco.

insereEspecifico(0, R2, [_|M], R) :- inserir(R2, M, R). % insere a nova lista com o elemento decrementado na posição certa

insereEspecifico(I, R2, [X|M], [X|R]) :- I1 is I -1,    % Enquanto indice não chegar a zero, serão adicionadas as listas dentro da lista
                                         insereEspecifico(I1,R2, M, R).

buscaTroca(0, [X|LS], R) :- B is X - 1,       % Irá retornar a lista específica com o elemento decrementado
                            inserir(B,LS,R).

buscaTroca(I, [X|LS], [X|R]) :- 	I1 is I-1,   % Enquanto o índice nao chegar a zero
                                  buscaTroca(I1,LS,R).

troca(L, C, M, R) :- busca(L, M, R1) ->
                     buscaTroca(C, R1, R2),
                     insereEspecifico(L, R2, M, R),
                     tamLista(M, Lin),
                     tamLista(R2, Col),
                     write('\nMatriz Anterior\n'),
                     printMatriz(Lin, Col, M),
                     write('\nApos Movimento\n'),
                     printMatriz(Lin, Col, R),
                     open('c:/users/adriana/desktop/disciplinas19.1/linguagens/game_prolog_lp/matriz.txt',append,I),
                     write(I,'_________________________________\n'), close(I),
                     write('\n_________________________________');
                     fail.

% ---------- Andar na matriz ------------

mainPred(L,_,M,_) :- tamLista(M, Lin),
                      L > Lin -> !.

mainPred(L,C,M,M1) :- busca(L,M,R1),
                      buscaTroca(C, R1, R),
                      tamLista(R, Col),
                      C =< Col ->
                      troca(L, C, M, M2),
                      C1 is C + 1,
                      mainPred(L, C1, M2, M1);
                      L1 is L + 1,
                      C2 is  0,
                      mainPred(L1, C2, M, M1).
