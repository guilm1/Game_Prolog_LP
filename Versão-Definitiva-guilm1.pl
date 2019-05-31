% Dada uma lista, fornece o tamanho da mesma
tamLista([],0).
tamLista([_],0).  % retornar quantidade de linhas ou Colunas
tamLista([_|XS],R):-
  tamLista(XS, A), R is A+1.
% --------------------------------------------------------------
% Busca um elemento no índice i de uma lista
busca(0,[X|_LS], X).
busca(I, [_X|LS], R):-
  I1 is I-1, busca(I1, LS, R).

% Procura um elemento na coordena i, J de uma matriz
finder(I, J, M, R):-
  busca(I, M, L),
  busca(J, L, E),
  R is E.
% --------------------------------------------------------------
% insere um elemento E na cabeça da lista L.
inserir(E, L, [E|L]).

% insere lista com o elemento decrementado na posição certa
insereEspecifico(0, R2, [_|M], R) :-
  inserir(R2, M, R).

insereEspecifico(I, R2, [X|M], [X|R]) :-
  I1 is I -1,
  insereEspecifico(I1,R2, M, R).

% Busca e troca a lista específica com o elemento decrementado
buscaTroca(0, [X|LS], R) :-
  B is X - 1,
  inserir(B,LS,R).

buscaTroca(I, [X|LS], [X|R]) :-
  I1 is I-1,
  buscaTroca(I1,LS,R).

% Fornece a matriz modificaa após um passo de movimento
troca(L, C, M, R) :-
  busca(L, M, R1),
  buscaTroca(C, R1, R2),
  insereEspecifico(L, R2, M, R).
% --------------------------------------------------------------
% Confere se o elemento na coordenada i,j é diferente de -1
checkingMove(I, J, Mtz):-
  finder(I, J, Mtz, F),
  F > -1.
% --------------------------------------------------------------
% Insere elemento na cabeça de uma lista
insereInicio(X, XS, [X|XS]):- !.

% Insere elemento na cauda de uma lista
insereFim(X, [Y], L):-
insereInicio(Y, [X], L).
insereFim(X, [Y|YS], L):-
  insereFim(X, YS, ZS),
  insereInicio(Y, ZS, L).
% -----------------------------------------------------------------
% Movimentações cardinais dada as coordenadas
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
MJ >= 0,
MI is I,
Mov = 'esquerda'  .
%Cima
movimentos(I, J, _LI, _LJ, MI, MJ, Mov):-
MI is I-1,
MI >= 0,
MJ is J,
Mov = 'cima' .
%Baixo
movimentos(I, J, LI, _LJ, MI, MJ, Mov):-
MI is I+1,
MI =< LI,
MJ is J,
Mov = 'baixo' .
% -----------------------------------------------------------------
% Confere se todos os elementos da matriz são iguais a -1 exceto
% a posição atual passada em I,J
testaParada(L,C,M) :-
  tamLista(M, TL),
  finder(L,C,M,E),
  testaLinha(TL, M, E, L, C).

testaLinha(-1,_,_,_,_).
testaLinha(LAtual,M,E,L,C) :-
  busca(LAtual, M, R1),
  tamLista(R1, TC),
  TAux is TC + 1,
  testaElemento(0,TAux,R1,E,LAtual,L,C),
  I1 is LAtual-1,
  testaLinha(I1,M,E,L,C).

testaElemento(TC,TC,[],_,_,_,_).
testaElemento(I,TC, [X|XS], E, LAtual, L, C) :-
  X =:= -1 ->
  I1 is I+1,
  testaElemento(I1,TC, XS, E, LAtual, L, C);
  L =:= LAtual,
  C =:= I,
  X =:= 0->
  I1 is I+1,
  testaElemento(I1, TC, XS, E, LAtual, L, C);
  fail.
% -----------------------------------------------------------------
% Monta o conjunto de passos inserindo o movimento no fim da lista
resposta(X,[],[X]):- !.
resposta(X, L, R):-
  insereFim(X, L, R1),
  R = R1.
% -----------------------------------------------------------------
% Ler arquivo enquanto o fluxo de informação não chegar ao fim do
% arquivo
lerPassos(F,[]) :-
  at_end_of_stream(F), !.

lerPassos(F,[X|L]) :-
  \+ at_end_of_stream(F),
  read(F,X),
  lerPassos(F,L).

lerArq(L):-
  open('C:/Users/Adriana/Desktop/temp.txt',read,F),
  lerPassos(F, L),
  close(F), nl.

% Limpa arquivo abringo um fluxo de escrita vazio
  clear :-
    open('C:/Users/Adriana/Desktop/temp.txt',write,F),
    open('C:/Users/Adriana/Desktop/Disciplinas19.1/Linguagens/Game_Prolog_LP/matriz.txt',write,G),
    write(G,''),
    write(F,''),
    close(G),
    close(F).

% escreve no arquivo o que for passado no parâmetro
  show(M) :-
    open('C:/Users/Adriana/Desktop/temp.txt',write,F),
    write(F,M),
    close(F).
% --------------------------------------------------------------------
% Testa\Executa as possibilidades de movimentos montando os conjuntos
% de caminhos a serem seguidos para atingir o objetivo do jogo
newMove(I, J, LI, LJ, Mtz,XS):-
  testaParada(I, J, Mtz)->
    open('C:/Users/Adriana/Desktop/temp.txt',append,F),
    open('C:/Users/Adriana/Desktop/Disciplinas19.1/Linguagens/Game_Prolog_LP/matriz.txt',append,G),
      %write(XS),write('\n'),
      write(G,XS),write(G,'\n'),
      write(F,XS),write(F,'.\n'),
      close(F),close(G),XS=[];
    movimentos(I, J, LI, LJ, RI, RJ, Mov),
    checkingMove(RI,RJ,Mtz),
    troca(I, J, Mtz, InterMat),
    resposta(Mov,XS, R1),
    newMove(RI, RJ, LI, LJ, InterMat,R1).

newMove(_,_,_,_,_,XS):-XS=[].
% -------------------------------------------------------------------
% predicado para iniciar o game passando a posição de início desejada
% a matriz inicial e o resultado da lista de movimentos
inicio(I,J,Mtz,L):-
  clear,
  tamLista(Mtz,TL),
  busca(0,Mtz,Col),
  tamLista(Col, TC),
  newMove(I,J,TL,TC,Mtz,_),
  lerArq(L),
  show(L).
% -------------------------------------------------------------------
% Convecionamos que os testes devem ser feitos assim:
% inicio(I,J,Mtz,L), tamLista(L,R).
% sendo I, J a posição inicial; Mtz, a matriz inicial;
% L, a lista de movimentos; R, a quantidade de soluções
