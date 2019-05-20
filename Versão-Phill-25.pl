/* 
seek: função de busca por indice e retorna a linha e a uma coluna antes, retorna a calda. O fato de retornar uma coluna antes é para na proxima função manipular.
Essa função chama a função game.

game: pega a cabeça da lista, testa para ver se é > que 0 se for(->;) chama a seek com as coordenadas.
Possui outras chamadas com coordenadas que simulam cima, baixo, direita e esquerda.

*/

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

busca(0,[X|LS], X).

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

checkingMove(I, J, Mtz, X):- % recebe coordenadas (i,j) e uma matriz. 
	
	finder(I, J, Mtz, F),    % em seguida, busca-se o elemento das coordenadas
	F =\= -1 -> X is 1;		 % Testa se o elemento é diferente de -1, se verdade o retorno recebe 1, se não 0.
	X is 0,
	!.
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







