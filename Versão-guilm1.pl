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
    write(G,'teste.'),
    close(G),
    nl.
% -----------------------------------------------------------------------------------
    imptab(Lin,Col):-     % Imprime uma matriz de Lin linhas e Col colunas.
    	imp(1,Lin,1,Col).  	% O predicado imp/4, abaixo é quem faz todo o trabalho.

    imp(L,Lin,_,_):-      % Imprime uma matriz de coordenadas compreendidas entre
    	L > Lin, !.        	% L e Lin e C e Col.  Se existir um objeto em uma
    imp(L,Lin,C,Col):-    % determinada posição (dada por uma relação pos(Obj,(L,C)),
    	C > Col, !, nl,    	% externa), imp/4 irá imprimir o conteudo da variável
    	L1 is L+1,         	% Obj (o "nome" do objeto), caso contrário irá imprimir
    	imp(L1,Lin,1,Col). 	% '  --'.  Este predicado é muito útil para imprimir o
    imp(L,Lin,C,Col):-    % estado de um conjunto de objetos sobre um tabuleiro ou
    	( pos(Obj,(L,C)) -> 	% matriz e pode ser adaptado para diferentes situações.
    	  ( write('  '),    	%
          	    write( Obj) );  	% Faça o teste:
    	    write('  --') ),	%
    	C1 is C+1,          	%        ?-assert(pos(m1,(3,5))),imptab(10,10).
    	imp(L,Lin,C1,Col).
% -----------------------------------------------------------------------------------
      %%  zero_matrix(+Dimension, ?Matrix) is det
      %   Generates a square zero matrix K with dimension n*n.
      %   Uses zero_matrix/3 with both n and m equal.

      zero_matrix(N, K) :-
          zero_matrix(N, N, K).

      %%  zero_matrix(+Rows, +Columns, ?Matrix) is det
      %   Generates a zero matrix K with n rows and m zeros in each row.
      %   Uses zero_vector/2 to generate each row of zero vectors.

      zero_matrix(0, _, []) :- !.
      zero_matrix(N, M, [K|Ks]) :-
          N1 is N - 1,
          write('|'),
          zero_vector(M, K),
          write('|'),
          write('\n'),
          zero_matrix(N1, M, Ks).

      %%  zero_vector(+Size, ?List) is det
      %   Generates a m long vector containing only zeros.

      zero_vector(0, []) :- !.
      zero_vector(M, [1|Ks]) :-
          M1 is M - 1,write(' 1 '),
          zero_vector(M1, Ks).
% --------------------------------------------------------------------------------
