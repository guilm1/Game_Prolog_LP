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
	
	
finder(I, J, M, R):-
	busca(I, M, L) ->
	busca(J, L, E), R is E;
	fail.
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
	I =< TI, 
	J =< TJ, 
	checkingMove(I, J, Mtz) ->
	write(M).
%-------------Movimento------------------------------------------------------------------
move(I, J, Mtz, R):-
	%Direita
	D is J+1,
	checkingMaster(I, D, Mtz, direita) -> write('direita'), move(I, D, Mtz, R);
	%Esquerda
	E is J-1,
	checkingMaster(I, E, Mtz, esquerda) -> write('esquerda'), move(I, E, Mtz, R);
	%Cima
	C is I+1,
	checkingMaster(C, J, Mtz, cima) -> write('cima'), move(C, J, Mtz, R);
	%Baixo
	B is I-1,
	checkingMaster(B, J, Mtz, baixo) -> write('baixo'), move(B, J, Mtz, R);
	
	fail.
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







