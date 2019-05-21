/*
seek: função de busca por indice e retorna a linha e a uma coluna antes, retorna a calda. O fato de retornar uma coluna antes é para na proxima função manipular.
Essa função chama a função game.

game: pega a cabeça da lista, testa para ver se é > que 0 se for(->;) chama a seek com as coordenadas.
Possui outras chamadas com coordenadas que simulam cima, baixo, direita e esquerda.

*/
%------------------Tamanho da Lista--------------------------------------

tamLista([_],0).  % retornar quantidade de linhas ou Colunas
tamLista([_|XS],R):- tamLista(XS, A), R is A+1.

%-------------------insere no inicio------------------------------------------
insereInicio(X,[], [X]).
insereInicio(X, XS, [X|XS]):- !.


%-------------------insere no fim------------------------------------------
insereFim(X, [], [X]).

insereFim(X, [Y], L):-
	insereInicio(Y, [X], L).

insereFim(X, [Y|YS], L):-
	insereFim(X, YS, ZS),
	insereInicio(Y, ZS, L).
%-----------Busca pelo Indice--------------------------

busca(0,[X|_LS], X).

busca(I, [_X|LS], R):-
	I1 is I-1,
	busca(I1, LS, R).

  espaco :- open('c:/users/adriana/desktop/disciplinas19.1/linguagens/game_prolog_lp/matriz.txt',append,F),
            write(F,'\n'), write('\n'),
            close(F).

  printMatriz(-1, _, _) :- !.     % Predicado para printar matriz
  printMatriz(L, C, M) :- open('c:/users/adriana/desktop/disciplinas19.1/linguagens/game_prolog_lp/matriz.txt',append,F),
                          write(F, '|'), write('|'),
                          busca(L, M, R1), write(F, R1), write(F, '|\n'),
                          write(R1), write('|\n'),close(F),
                          L1 is L - 1,
                          printMatriz(L1,C,M), espaco.


finder(I, J, M, R):-
	busca(I, M, L) ->
	busca(J, L, E), R is E;
	fail.

%---------------------------------------------------------------------------

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


insereEspecifico(0, R2, [_|M], R) :- inserir(R2, M, R). % insere a nova lista com o elemento decrementado na posição certa

insereEspecifico(I, R2, [X|M], [X|R]) :- I1 is I -1,    % Enquanto indice não chegar a zero, serão adicionadas as listas dentro da lista
                                         insereEspecifico(I1,R2, M, R).

buscaTroca(0, [X|LS], R) :- B is X - 1,       % Irá retornar a lista específica com o elemento decrementado
                            inserir(B,LS,R).

buscaTroca(I, [X|LS], [X|R]) :- 	I1 is I-1,   % Enquanto o índice nao chegar a zero
                                  buscaTroca(I1,LS,R).



troca(L, C, M, R) :- busca(L, M, R1) ->
                     buscaTroca(C, R1, R2),
                     insereEspecifico(L, R2, M, R).
%----------------------Teste Game----------------------------------

ateFim([],[]).
ateFim([E|Li], RLi):- % Pega todos os elementos da linha, decrementa, e coloca em uma nova lista

	ateFim(Li, NLi),
	EN is E-1,
	insereInicio(EN,NLi, RLi).


testGame([],_Rmtz):-!.
testGame([Li|Mtz], RMtz):- % pega uma "linha" da matriz
	testGame(Mtz, IMtz),
	ateFim(Li, DLi),
	insereFim(DLi, IMtz, RMtz).

%-----------------Verifica Movimento------------------------------------

checkingMove(I, J, Mtz):- % recebe coordenadas (i,j) e uma matriz.

	finder(I, J, Mtz, F),    % em seguida, busca-se o elemento das coordenadas
	F \= -1.		 			% Testa se o elemento é diferente de -1.


%-------------------------Testes---------------------------------------------------


checkingMaster(I, J, Mtz, M):-
	tamLista(Mtz, TI),
	busca(0, Mtz, HM),
	tamLista(HM, TJ),
	I =< TI, I > -1,
	J =< TJ, J > -1,
	checkingMove(I, J, Mtz) ->
	write(M), write('\n');
	false.
%-------------Movimento------------------------------------------------------------------
moveE(I, J, Mtz, X):-
	%Esquerda
	E is J-1,
	checkingMaster(I, E, Mtz, esquerda) -> troca(I, J, Mtz, R), printMatriz(2,3,R), moveE(I, E, R, X);
	%Cima
	C is I+1,
	checkingMaster(C, J, Mtz, cima)     -> troca(I, J, Mtz, R), printMatriz(2,3,R), moveC(C, J, R, X);
	%Baixo
	B is I-1,
	checkingMaster(B, J, Mtz, baixo)    -> troca(I, J, Mtz, R), printMatriz(2,3,R), moveB(B, J, R, X);
	%Direita
	D is J+1,
	checkingMaster(I, D, Mtz, direita)  -> troca(I, J, Mtz, R), printMatriz(2,3,R), move(I, D, R, X);

	!.
moveC(I, J, Mtz, X):-
	%Cima
	C is I+1,
	checkingMaster(C, J, Mtz, cima)     -> troca(I, J, Mtz, R), printMatriz(2,3,R), moveC(C, J, R, X);
	%Direita
	D is J+1,
	checkingMaster(I, D, Mtz, direita)  -> troca(I, J, Mtz, R), printMatriz(2,3,R), move(I, D, R, X);
	%Esquerda
	E is J-1,
	checkingMaster(I, E, Mtz, esquerda) -> troca(I, J, Mtz, R), printMatriz(2,3,R), moveE(I, E, R, X);
	%Baixo
	B is I-1,
	checkingMaster(B, J, Mtz, baixo)    -> troca(I, J, Mtz, R), printMatriz(2,3,R), move(B, J, R, X);

	!.

moveB(I, J, Mtz, X):-
	%Baixo
	B is I-1,
	checkingMaster(B, J, Mtz, baixo)    -> troca(I, J, Mtz, R), printMatriz(2,3,R), moveB(B, J, R, X);
	%Direita
	D is J+1,
	checkingMaster(I, D, Mtz, direita)  -> troca(I, J, Mtz, R), printMatriz(2,3,R), move(I, D, R, X);
	%Esquerda
	E is J-1,
	checkingMaster(I, E, Mtz, esquerda) -> troca(I, J, Mtz, R), printMatriz(2,3,R), moveE(I, E, R, X);
	%Cima
	C is I+1,
	checkingMaster(C, J, Mtz, cima)     -> troca(I, J, Mtz, R), printMatriz(2,3,R), moveC(C, J, R, X);

	!.

move(I, J, Mtz, X):-
	%Direita
	D is J+1,
	checkingMaster(I, D, Mtz, direita)  -> troca(I, J, Mtz, R), printMatriz(2,3,R), move(I, D, R, X);
	%Cima
	C is I+1,
	checkingMaster(C, J, Mtz, cima)     -> troca(I, J, Mtz, R), printMatriz(2,3,R), moveC(C, J, R, X);
	%Baixo
	B is I-1,
	checkingMaster(B, J, Mtz, baixo)    -> troca(I, J, Mtz, R), printMatriz(2,3,R), moveB(B, J, R, X);
	%Esquerda
	E is J-1,
	checkingMaster(I, E, Mtz, esquerda) -> troca(I, J, Mtz, R), printMatriz(2,3,R), moveE(I, E, R, X);
	!.

  movimento(I, J, M, R) :- move(I, J, M, R).

%----------------------------Ideia para movimentação--------------------------------------------
/*
Movimento Direita:
decrementa posição atual;
verifica se j+1 é < que o tamanho da lista;
se sim, verifica se a posição (i,j+1) é válida para movimentação;
Se sim , executa a movimentação(pode ser chamando esse predicado???);
Se não, proximo movimento (Cima, baixo...).

*/


% Proximos Passos:
% 1- Elaborar predicado: Cima, Baixo, Direita, Esquerda.
% 2- Tratar posições com verificação se == -1
% 3- Conferir se todas as posições da matriz são == -1
% 4- Condição de Game Over (Se as posições ao redor da posição atual é igual são == -1)
