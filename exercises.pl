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
