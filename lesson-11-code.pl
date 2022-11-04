% A Prolog program is a list of clauses
% Fact = goal
% Rule = goal :- resolvent

member([H|T], H, T).
member([H|T], E, [H|T2]):- member(T, E, T2).

permutation([], []).
permutation(L, [H | TP]) :- 
    member(L, H, T), 
    permutation(T, TP).

a.              % This clause is a fact
b.              % Fact = goal
b.
b :- z.         % This clause is a rule: b is the "head" and z is the "body"
c.
c :- a, c.      % Rule = goal :- resolvent 
c :- b.
d :- d.

father_abraham_isaac.
father_terach_abraham.
grandfather_terach_isaac :- father_abraham_isaac, father_terach_abraham.

father(abraham, isaac).
father(terach, abraham).
grandfather(GF, GS) :- father(GF, F), father(F, GS).

element(H, cons(H, T)).
element(E, cons(H, T)) :- element(E, T).

odd(1).         % 1 is odd
odd(3).         % 3 is odd
sum(2, 3, 5).   % 2,3,5 are in the sum relation

b_not(b_true, b_false).
b_not(b_false, b_true).
b_and(B, b_true, B).
b_and(B, b_false, b_false).
b_or(B1, B2, B) :-          % (a and b) = !(!a or !b)
    b_not(B1, NB1), b_not(B2, NB2),  b_and(NB1, NB2, NB), b_not(NB, B).
b_implies(B1, B2, B) :-     % a --> b = !a or b
    b_not(B1, NB1), b_or(NB1, B2, B).
    
succ(X, s(X)).
sum(X, zero, X).
sum(X, s(Y), s(Z)) :- sum(X, Y, Z).
mul(X, zero, zero).
mul(X, s(Y), Z) :- mul(X, Y, W), sum(W, X, Z).
dec(s(X), X).
factorial(zero, s(zero)).
factorial(s(X), Y):-factorial(X, Z), mul(s(X), Z, Y).
greater(s(_), zero).
greater(s(N), s(M)) :- greater(N, M).
range(N1, N2, N1).
range(N1, N2, N) :- greater(N2, N1), range(s(N1), N2, N).
nextprev(s(N), N, s(s(N))).

% relates a list with one of its elements
find([E|_],E).
find([_|T],E) :- find(T,E).

% relates a list with with one of its elements and its Peano position
position([E|_],zero,E).
position([H|T],s(N),E) :- position(T,N,E).

% relates two lists with their concatenation (similar to append)
join([],L,L).
join([H|T],L,[H|M]):- join(T,L,M).

% relates a list with the sum of its elements
sum([], 0).
sum([H|T], S) :- sum(T, N), S is H + N. 
