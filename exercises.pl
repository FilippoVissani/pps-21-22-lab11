% all(+T, +L) relates a list with a template for all its elements
% e.g.: all(1, [1,1,1]).
% e.g.: all(p(_), [p(1), p(2), p(3)]).
% this solution does not work if the template is a functor.
all(_, []).
all(H, [H|T]) :- all(H, T).

all2(_, []).
all2(H, [H2|T]) :- copy_term(H, H2), all2(H, T).

% exercise 1.1
% dropAny(?Elem, ?List, ?OutList)
dropAny(E, [E|T], T).
dropAny(X, [H|T], [H|L]) :- dropAny(X, T, L).

% dropFirst: drops only the first occurrence
dropFirst(E, [E|T], T) :- !.
dropFirst(X, [H|T], [H|L]) :- dropFirst(X, T, L).

% dropLast: drops only the last occurrence
dropLast(E, [E|T], T) :- !.
dropLast(X, [H|T], [H|L]) :- dropLast(X, T, L), !.

% dropAll: drop all occurrences, returning a single list as result
dropAll(E, [], []).
dropAll(E, [H|T], [H|T2]) :- E \= H, dropAll(E, T, T2).
dropAll(E, [E|T], T2) :- dropAll(E, T, T2).

% exercise 2.1
% fromList(+List, -Graph)
fromList([_], []).
fromList([H1, H2|T], [e(H1, H2)|L]) :- fromList([H2|T], L).

% exercise 2.2
% fromCircList(+List, -Graph)
% which implementation?
% fromCircList([1,2,3],[e(1,2),e(2,3),e(3,1)]).
% fromCircList([1,2],[e(1,2),e(2,1)]).
% fromCircList([1],[e(1,1)]).
fromCircList([H|T], G) :- fromCircList([H|T], H, G).
fromCircList([E], H, [e(E, H)]).
fromCircList([E1, E2|T], H, [e(E1, E2)|L]) :- fromCircList([E2|T], H, L).

% exercise 2.3
% inDegree(+Graph, +Node, -Deg)
% Deg is the number of edges leading into Node
% in_degree([e(1,2), e(1,3), e(3,2)], 2, 2).
% in_degree([e(1,2), e(1,3), e(3,2)], 3, 1).
% in_degree([e(1,2), e(1,3), e(3,2)], 1, 0).
in_degree([], _, 0).
in_degree([e(_,X)|T], N, C) :- X \= N, in_degree(T, N, C).
in_degree([e(_,N)|T], N, C) :- in_degree(T, N, C2), C is C2 + 1.

% exercise 2.4
% dropNode(+Graph, +Node, -OutGraph)
% drop all edges starting and leaving from a Node
% use dropAll defined in 1.1??
dropNode(G, N, OG) :- dropAll(G, e(N, _), G2), dropAll(G2, e(_, N), GO).

% exercise 2.5
% reaching (+ Graph , + Node , - List )
% all the nodes that can be reached in 1 step from Node
% possibly use findall , looking for e ( Node , _ ) combined
% with member (? Elem ,? List )
% reaching([e(1,2),e(1,3),e(2,3)],1,L). -> L/[2,3]
% reaching([e(1,2),e(1,2),e(2,3)],1,L). -> L/[2,2])
reaching(G, N, L) :- findall(N2, member(e(N, N2), G), L).
