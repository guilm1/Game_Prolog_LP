/* 
seek: função de busca por indice e retorna a linha e a uma coluna antes, retorna a calda. O fato de retornar uma coluna antes é para na proxima função manipular.
Essa função chama a função game.

game: pega a cabeça da lista, testa para ver se é > que 0 se for(->;) chama a seek com as coordenadas.
Possui outras chamadas com coordenadas que simulam cima, baixo, direita e esquerda.

*/

%-----------Busca pelo Indice--------------------------

busca(0,[X|_L], X).
busca(I, [X|LS], R):-
	I1 is I-1,
	busca(I1, LS, R).

finder(I, J, M, R):-
	busca(J, M, L) ->
	busca(I, L, E), R is E;
	fail.

%--------------------------------------------------------


busca1(0,[X|_L], X).
busca1(I, [X|LS], R):-
	I1 is I-1,
	busca1(I1, LS, R).

finder1(I, J, M, R):-
	busca1(J, M, L) ->
	busca1(I, L, E), R is E;
	fail.