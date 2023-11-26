:-  use_module(library(clpfd)), initialization(main).

%Acima | Direita | Abaixo | Esquerda
%Menor: -
%Maior: +
%Sem comparador: /
comparadores(ComparadoresPorCelula) :-
    ComparadoresPorCelula = [
    [['/', '+', '+', '/'], ['/', '+', '-', '-'], ['/', '/', '-', '-'], ['/', '-', '+', '/'], ['/', '+', '+', '+'], ['/', '/', '+', '-'], ['/', '-', '-', '/'], ['/', '+', '+', '+'], ['/', '/', '-', '-']],
    [['-', '-', '-', '/'], ['+', '-', '+', '+'], ['+', '/', '+', '+'], ['-', '-', '-', '/'], ['-', '+', '-', '+'], ['-', '/', '-', '-'], ['+', '+', '+', '/'], ['-', '-', '+', '-'], ['+', '/', '+', '+']],
    [['+', '+', '/', '/'], ['-', '+', '/', '-'], ['-', '/', '/', '-'], ['+', '+', '/', '/'], ['+', '-', '/', '-'], ['+', '/', '/', '+'], ['-', '+', '/', '/'], ['-', '-', '/', '-'], ['-', '/', '/', '+']],
    [['/', '-', '-', '/'], ['/', '-', '-', '+'], ['/', '/', '-', '+'], ['/', '+', '+', '/'], ['/', '-', '+', '-'], ['/', '/', '+', '+'], ['/', '+', '+', '/'], ['/', '+', '-', '-'], ['/', '/', '+', '-']],
    [['+', '-', '+', '/'], ['+', '-', '+', '+'], ['+', '/', '+', '+'], ['-', '-', '+', '/'], ['-', '-', '+', '+'], ['-', '/', '+', '+'], ['-', '-', '-', '/'], ['+', '+', '-', '+'], ['-', '/', '-', '-']],
    [['-', '-', '/', '/'], ['-', '+', '/', '+'], ['-', '/', '/', '-'], ['-', '-', '/', '/'], ['-', '-', '/', '+'], ['-', '/', '/', '+'], ['+', '-', '/', '/'], ['+', '+', '/', '+'], ['+', '/', '/', '-']],
    [['/', '+', '+', '/'], ['/', '-', '+', '-'], ['/', '/', '+', '+'], ['/', '+', '+', '/'], ['/', '-', '-', '-'], ['/', '/', '-', '+'], ['/', '+', '+', '/'], ['/', '+', '+', '-'], ['/', '/', '-', '-']],
    [['-', '+', '-', '/'], ['-', '-', '-', '-'], ['-', '/', '-', '+'], ['-', '-', '+', '/'], ['+', '-', '+', '+'], ['+', '/', '+', '+'], ['-', '+', '+', '/'], ['-', '-', '+', '-'], ['+', '/', '-', '+']],
    [['+', '-', '/', '/'], ['+', '+', '/', '+'], ['+', '/', '/', '-'], ['-', '+', '/', '/'], ['-', '+', '/', '-'], ['-', '/', '/', '-'], ['-', '+', '/', '/'], ['-', '-', '/', '-'], ['+', '/', '/', '+']]].



%Achar o i-ésimo da lista
%O 0-ésimo item da lista é a cabeça da lista, se ela tiver um ou mais itens.
%O I-ésimo item da lista é o (I-1)-ésimo item da cauda da lista.
nthLista(0, [H|_], H).
nthLista(I, [_|T], X) :- I2 is I - 1, nthLista(I2, T, X).

%Achar o i-ésimo da matriz
nthMatriz(X, Y, Lista, Z) :- nthLista(X, Lista, W), nthLista(Y, W, Z).


%Comparacoes entre celulas
compara(_, _, _, _, '/').
compara(Numero1, Tabuleiro, X, Y, '+') :- nthMatriz(X, Y, Tabuleiro, Numero2), Numero1 > Numero2.
compara(Numero1, Tabuleiro, X, Y, '-') :- nthMatriz(X, Y, Tabuleiro, Numero2), Numero1 < Numero2.


%Encontra os valores válidos para a célula na linha X, coluna Y
encontraValoresValidos(Numero, X, Y, Tabuleiro, Comparacoes) :- 
    %Comparadores da célula na linha X, coluna Y
    nthMatriz(I, J, Comparacoes, ComparadoresCelula),

    %Divide os comparadores por direção
    nthLista(0, ComparadoresCelula, ComparadorAcima),
    nthLista(1, ComparadoresCelula, ComparadorDireita),
    nthLista(2, ComparadoresCelula, ComparadorAbaixo),
    nthLista(3, ComparadoresCelula, ComparadorEsquerda),

    %Define os vizinhos
    Acima is X - 1,
    Direita is Y + 1,
    Abaixo is X + 1,
    Esquerda is Y - 1,

    %Define as comparações por direção
    compara(Numero, Tabuleiro, Acima, Y, ComparadorAcima),
    compara(Numero, Tabuleiro, X, Direita, ComparadorDireita),
    compara(Numero, Tabuleiro, Abaixo, Y, ComparadorAbaixo),
    compara(Numero, Tabuleiro, X, Esquerda, ComparadorEsquerda).


%Percorre todas posições da matriz e define as comparações referentes a cada posição.
regras(_, _, 9, _).
regras(Tabuleiro, Comparacoes, X, 9) :- A is X + 1, regras(Tabuleiro, Comparacoes, A, 0).
regras(Tabuleiro, Comparacoes, X, Y) :- 
    nthMatriz(X, Y, Tabuleiro, Numero),
    encontraValoresValidos(Numero, X, Y, Tabuleiro, Comparacoes),
    A is Y + 1,
    regras(Tabuleiro, Comparacoes, X, A).


/*
 Definição o que é um tabuleiro válido de vergleich.
 Um possível tabuleiro válido de vergleich é uma matriz de
 ordem 9 onde cada linha, coluna e região contem todos os números 
 de 1 a 9 sem repetições. Além disso, cada posição deve satisfazer
 certas comparações (maior ou menor) com seus vizinhos de região.
 */
vergleich(Tabuleiro, Comparacoes) :-
    %O tabuleiro tem 9 linhas
    length(Tabuleiro, 9),

    %Cada linha 9 colunas
    maplist(same_length(Tabuleiro), Tabuleiro),

    %Concatena todos os números do tabuleiro em TodosOsNumeroeros
    append(Tabuleiro, TodosOsNumeroeros),

    %O tabuleiro tem apenas números entre 1 e 9
    TodosOsNumeroeros ins 1..9,

    %O tabuleiro segue a regra do Tabuleiro vergleichs
    regras(Tabuleiro, Comparacoes, 0, 0),

    %Todas as linhas possuem números entre 1 e 9 sem repetições
    maplist(all_distinct, Tabuleiro),

    %Inverte as linhas e colunas
    transpose(Tabuleiro, Columns),

    %Todas as colunas possuem números entre 1 e 9 sem repetições
    maplist(all_distinct, Columns), 

    %Nomeia todas as linhas da Matriz
    Tabuleiro = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],


    %A partir das linhas nomeadas, divide em 3 blocos de 3 linhas cada
    %Define que cada bloco contem 3 regiões que devem conter todos os números entre 1 e 9 sem repetições
    blocks(As, Bs, Cs), % Linhas (0-2)
    blocks(Ds, Es, Fs), % Linhas (3-5)
    blocks(Gs, Hs, Is). % Linhas (6-8)


/*
    Recebe 3 linhas, cada uma com tamanhos iguais entre si que podem ser 9, 6, 3 ou 0
    Vai andando em blocos de 3 por essas linhas até chegar ao final.
    Pega os 3 primeiros itens de cada linha e diz que todos os 9 itens precisam ser diferentes.
    Ao final repete o processo para a calda ou o que sobrou da lista.
*/
blocks([], [], []).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
    all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
    blocks(Ns1, Ns2, Ns3).


main :- matrizComparacoes(Comparacoes),
    vergleich(P, Comparacoes),
    maplist(label, P), maplist(portray_clause, P),
    halt.