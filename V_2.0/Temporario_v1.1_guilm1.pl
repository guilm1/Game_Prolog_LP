/*
seek: função de busca por indice e retorna a linha e a uma coluna antes, retorna a calda.
O fato de retornar uma coluna antes é para na proxima função manipular. Essa função chama a função game.

game: pega a cabeça da lista, testa para ver se é > que 0 se for(->;)
chama a seek com as coordenadas. Possui outras chamadas com coordenadas
que simulam cima, baixo, direita e esquerda.
*/

%------------------Tamanho da Lista---------------------------------------------
tamLista([],0).
tamLista([_],0).  % retornar quantidade de linhas ou Colunas
tamLista([_|XS],R):- tamLista(XS, A), R is A+1.

%-----------Busca pelo Indice---------------------------------------------------
busca(0,[X|_LS], X).
busca(I, [_X|LS], R):- I1 is I-1, busca(I1, LS, R).

finder(I, J, M, R):-
  busca(I, M, L) ,
  busca(J, L, E),
   R is E.

% ------------------------------------------------------------------------------
% Passar o elemento da lista que eu quero trocar, a lista e o elemento novo
% swap(Elemento, ETtrocado, Lista, Resposta).

remover(X,[X|C],C).	%  É possível remover um elemento X de uma lista onde
remover(X,[Y|C],[Y|D]):-	%  X é a cabeça.  Se X não é a cabeça da lista, então
remover(X,C,D).   	%  X deve ser removido d corpo da lista.

inserir(X,L,L1):-		%  inserir em função de remover.
remover(X,L1,L).	%  A inserção é sempre feita na cabeça de L.

inserirT(E, L, [E|L]). % alternativa para inserção.

swap(E, ET, [E|XS], R) :- inserir(ET,XS,R).
swap(E, ET, [X|XS], [X|R]) :- swap(E,ET,XS,R).

%-------------------------------------------------------------------------------
% insere a nova lista com o elemento decrementado na posição certa
insereEspecifico(0, R2, [_|M], R) :- inserirT(R2, M, R).

% Enquanto indice não chegar a zero, serão adicionadas as listas dentro da lista
insereEspecifico(I, R2, [X|M], [X|R]) :- I1 is I -1, insereEspecifico(I1,R2, M, R).

% Irá retornar a lista específica com o elemento decrementado
buscaTroca(0, [X|LS], R) :- B is X - 1, inserirT(B,LS,R).

% Enquanto o índice nao chegar a zero
buscaTroca(I, [X|LS], [X|R]) :- 	I1 is I-1, buscaTroca(I1,LS,R).

% Decrementa Posição (I,J) na matriz
troca(L, C, M, R) :- busca(L, M, R1),
                     buscaTroca(C, R1, R2),
                     insereEspecifico(L, R2, M, R).

%-------------------------------------Impressões--------------------------------
marcadorAux(0, [_|LS], R) :- inserir('P*',LS,R).
marcadorAux(I, [X|LS], [X|R]) :- 	I1 is I-1, marcadorAux(I1,LS,R). % mesmaLogica pred buscaTrocaa

colocaListaMarcada(0, R2, [_|M], R) :- inserir(R2, M, R).
colocaListaMarcada(I, R2, [X|M], [X|R]) :- I1 is I -1, colocaListaMarcada(I1,R2, M, R).

trocaPorMarcador(L, C, M, R) :- busca(L, M, R1) -> marcadorAux(C, R1, R2), colocaListaMarcada(L, R2, M, R). % mesma Logica pred trocaa

separador :- open('C:/Users/Philipe/Desktop/matriz.txt',append,F),
             write(F,'\n__________________________________\n'), write('\n________________________________\n'),
             close(F).

espaco :- open('C:/Users/Philipe/Desktop/matriz.txt',append,F),
          write(F,'\n'), write('\n'),
          close(F).

% Predicado para imprimir matriz
printMatriz(-1, _, _, _, _) :- !.
printMatriz(L, C, I, J, M) :- trocaPorMarcador(I,J,M,R),
													    open('C:/Users/Philipe/Desktop/matriz.txt',append,F),
                              write(F, '|'), write('|'), busca(L, R, R1), write(F, R1), write(F, '|\n'),
                              write(R1), write('|\n'),close(F), L1 is L - 1, printMatriz(L1,C,I,J,R).

% imprime coordenadas da posição atual
mostraPosicao(I,J) :- open('C:/Users/Philipe/Desktop/matriz.txt',append,F),
										  write(F,'Posição Atual: ('),write(F, I),write(F,', '),write(F,J),write(F,')\n'), close(F),
											write('Posicao Atual: ('),write(I),write(', '),write(J),write(')\n').

% imprime movimento feito, a matriz resultante e o valor do marcador P*
mostraDirecao(I, J, QL, QC, Mtz, M) :- open('C:/Users/Philipe/Desktop/matriz.txt',append,F),
	                                     write(F,'Movimento: '), write(F,M), write(F,'\nPosição Atual: ('),write(F, I),write(F,', '),
																			 write(F,J),write(F,')\n'), close(F), write('Movimento: '), write(M),write('\nPosicao Atual: ('),
																			 write(I),write(', '),write(J),write(')\n'),mostraValor(I,J,Mtz), printMatriz(QL,QC,I,J,Mtz), separador.

% imprime valor do marcador P*
mostraValor(I,J,M) :- open('C:/Users/Philipe/Desktop/matriz.txt',append,F),
											finder(I,J,M,E), write(F,'Valor P*= '),write(F,E),write('Valor P*: '),write(E),write(F,'\n'),
											write('\n'), close(F).

clear :- open('C:/Users/Adriana/Desktop/matriz.txt',write,F), write(F,''),close(F).
show(M) :- open('C:/Users/Adriana/Desktop/matriz.txt',write,F), write(F,M),close(F).
%-----------------Verifica Movimento--------------------------------------------
% recebe coordenadas (i,j) e uma matriz. Em seguida, busca-se o elemento das
% coordenadas e Testa se o elemento é diferente de -1.

checkingMove(I, J, Mtz):- finder(I, J, Mtz, F),  F > -1.

% Confere se os índices passados não estão fora do limite e executa o predicado acima.
checkingMaster(I, J, Mtz):- tamLista(Mtz, TI), busca(0, Mtz, HM), tamLista(HM, TJ),
														I =< TI, I > -1, J =< TJ, J > -1, checkingMove(I, J, Mtz);
														false.
%-------------------insere no inicio--------------------------------------------
            insereInicio(X, XS, [X|XS]):- !.

%-------------------insere no fim-----------------------------------------------
            insereFim(X, [Y], L):-
          	insereInicio(Y, [X], L).
            insereFim(X, [Y|YS], L):- insereFim(X, YS, ZS), insereInicio(Y, ZS, L).
%----------------------------Movimentos ----------------------------------------
% %movimentos(I, J, LI, LJ, MI, MJ).
% %Direita
% movimentos(I, J, _LI, LJ, MI, MJ):-
% MJ is J+1,
% MJ =< LJ,
% MI is I.
% %Esquerada
% movimentos(I, J, _LI, _, MI, MJ):-
% MJ is J-1,
% MJ >= 0, /*Acho que a primeira comparação não é necessária*/
% MI is I.
% %Cima
% movimentos(I, J, _LI, _LJ, MI, MJ):-
% MI is I-1, % acho que é por isso que está invertido na outra modelagem....
% MI >= 0,
% MJ is J.
% %Baixo
% movimentos(I, J, LI, _LJ, MI, MJ):-
% MI is I+1,
% MI =< LI,
% MJ is J.

%movimentos(I, J, LI, LJ, MI, MJ).
%Direita
movimentos(I, J, _LI, LJ, MI, MJ, Mov):-
MJ is J+1,
MJ =< LJ,
MI is I,
Mov = 'direita' .
%Esquerada
movimentos(I, J, _LI, LJ, MI, MJ, Mov):-
MJ is J-1,
MJ =< LJ,
MJ >= 0, /*Acho que a primeira comparação não é necessária*/
MI is I,
Mov = 'esquerda'  .
%Cima
movimentos(I, J, _LI, _LJ, MI, MJ, Mov):-
MI is I-1, % acho que é por isso que está invertido na outra modelagem....
MI >= 0,
MJ is J,
Mov = 'cima' .
%Baixo
movimentos(I, J, LI, _LJ, MI, MJ, Mov):-
MI is I+1,
MI =< LI,
MJ is J,
Mov = 'baixo' .
%------------------------New Move-----------------------------------------------
% newMove(I, J, LI, LJ, Mtz, XS, MtzR):-
%  testaParada(I,J,Mtz) -> write('\nPAREI');
%  movimentos(I, J, LI, LJ, RI, RJ),
%  checkingMove(RI,RJ,Mtz),
%  troca(I, J, Mtz, InterMat),
%  newMove(RI, RJ, LI, LJ, InterMat,[(I,J)|XS], MtzR).

%inicio(I,J,Mtz,XS,L):- tamLista(Mtz,TL), busca(0,Mtz,Col),
%                    tamLista(Col, TC),newMove(I,J,TL,TC,Mtz,XS,L).
%
%newMove(I, J, TL, TC, Mtz, XS,L):- testaParada(I, J, Mtz)->
%                                  write(XS),
%                                  write('\n'),
%                                  XS=[],
%                                  newMove(I,J,TL,TC,Mtz,XS,[XS|L]).
%
%newMove(I, J, LI, LJ, Mtz,XS,L):-
%      movimentos(I, J, LI, LJ, RI, RJ, Mov),
%      checkingMove(RI,RJ,Mtz),
%      troca(I, J, Mtz, InterMat),
%      resposta(Mov,XS, R1),
%      newMove(RI, RJ, LI, LJ, InterMat,R1,L).
%
%newMove(_,_,_,_,_,XS,_):-XS = [].


testaParada(L,C,M) :- tamLista(M, TL),
                      finder(L,C,M,E),
                      condMtz(TL, M, E, L, C).

condMtz(-1,_,_,_,_).
condMtz(LAtual,M,E,L,C) :- busca(LAtual, M, R1),
                           tamLista(R1, TC),
                           TAux is TC + 1,
                           condAux(0,TAux,R1,E,LAtual,L,C),
                           I1 is LAtual-1,
                           condMtz(I1,M,E,L,C).

condAux(TC,TC,[],_,_,_,_).
condAux(I,TC, [X|XS], E, LAtual, L, C) :- X =:= -1 ->
                                          I1 is I+1,
                                          condAux(I1,TC, XS, E, LAtual, L, C);
                                          L =:= LAtual,
                                          C =:= I,
                                          X =:= 0->
                                          I1 is I+1,
                                          condAux(I1, TC, XS, E, LAtual, L, C);
                                          fail.

                                          uniao([],L,L).
                                          uniao([X|XS],YS,ZS):- confere(X,YS,R), uniao(XS,R,ZS).
                                          confere(X,[],[X]).
                                          confere(X,[Y|YS],[Y|R]):- X \= Y, confere(X,YS,R).
                                          confere(X,[X|YS],[X|YS]).

                                          concat([],L,L).
                                          concat([X|Xs],L,[X|Ys]) :- concat(Xs,L,Ys).

resposta(X,[],[X]):- !.
resposta(X, L, R):- insereFim(X, L, R1), R = R1.



lerMat(F,[]) :- at_end_of_stream(F),!.
lerMat(F,[X|L]) :- \+ at_end_of_stream(F), read(F,X), lerMat(F,L).
prin(L):- open('C:/Users/Adriana/Desktop/matriz.txt',read,F), lerMat(F, L), close(F), nl.



inicio(I,J,Mtz,L):- clear, tamLista(Mtz,TL), busca(0,Mtz,Col),
                    tamLista(Col, TC),
                    newMove(I,J,TL,TC,Mtz,_),
                    prin(L),
                    show(L).


newMove(I, J, LI, LJ, Mtz,XS):- testaParada(I, J, Mtz)-> open('C:/Users/Adriana/Desktop/matriz.txt',append,F),
                                  %write(XS),write('\n'),
                                  write(F,XS),write(F,'.\n'),
                                  close(F),XS=[];
                                  movimentos(I, J, LI, LJ, RI, RJ, Mov),
                                  checkingMove(RI,RJ,Mtz),
                                  troca(I, J, Mtz, InterMat),
                                  resposta(Mov,XS, R1),
                                  newMove(RI, RJ, LI, LJ, InterMat,R1).

newMove(_,_,_,_,_,XS):-XS=[].


%  TESTES
% inicio(0,0,[[1,1],[1,1]],L), tamLista(L,R). R=18
% inicio(0,0,[[1,1,1],[1,1,1]],L), tamLista(L,R). R=119
% inicio(0,2,[[2,2,0],[2,2,-1]],L), tamLista(L,R). R=200
% inicio(0,2,[[2,2,0],[3,3,-1]],L), tamLista(L,R). R=525
% inicio(1,0,[[0,1],[3,3]],L), tamLista(L,R). R=50
% inicio(0,0,[[0,0,0],[0,0,0],[0,1,1],[0,1,0]],L), tamLista(L,R). R=159
% inicio(0,0,[[0,0,0],[0,0,0],[0,1,1],[0,0,0]],L), tamLista(L,R). R=68
% inicio(0,0,[[1,1,1],[1,1,1],[1,1,1]],L), tamLista(L,R). R=0
% inicio(0,0,[[0,0,0],[0,0,0],[0,0,0],[0,0,0]],L), tamLista(L,R). R=17
% inicio(0,0,[[1,0,0],[0,0,0],[0,1,1],[0,1,1]],L), tamLista(L,R). R=210
% inicio(0,0,[[0,0,0],[0,0,0],[0,1,1],[0,1,1]],L), tamLista(L,R). R=318
% Acredito que esses sejam o tipo de testes que precisamos tratar:
% inicio(0,0,[[0,-1]],L), tamLista(L,R). R=1, L = [_13014, end_of_file],
% inicio(0,0,[[0,-1],[-1,-1]],L), tamLista(L,R).  L = [_13094, end_of_file], R = 1
