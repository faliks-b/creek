plus(0, 0). plus(1, 0). plus(0, 1). plus(1, 1).
diff(0, 1). diff(1, 0). diff(0, -1). diff(-1, 0).
% Colour every cell black
% Constellations which do not satisfy the given conditions will be eliminated based on that
{ black(X, Y) } :- cell(X, Y).

% Determine the required amount of black cells surrounding a hint node
black_surrounding(X + A, Y + B) :- hint(X, Y, _), plus(A, B), black(X + A, Y + B).
black_count(X, Y, M) :- hint(X, Y, _), M = #count{ X + A, Y + B : hint(X, Y, _), plus(A, B), black_surrounding(X + A, Y + B) }.

% Delete all sets where hint nodes have an incorrect number of black cells around them
:- hint(X, Y, M), black_count(X, Y, N), M != N.

% Initialise white cells
white(X, Y) :- cell(X, Y), not black(X, Y).

% Define cell adjacency between two white cells
adj(X, Y, X + A, Y + B) :- white(X, Y), white(X + A, Y + B), diff(A, B).

% Using any white cell as a starting point, visit every adjacent white cell
connected(X, Y, X, Y, X, Y) :- white(X, Y).
connected(X1, Y1, X2, Y2, X, Y):- connected(X2, Y2, _, _, X, Y), adj(X2, Y2, X1, Y1).

% Delete all sets with no coherent path between any two white cells
:- white(X2, Y2), white(X, Y), not connected(X2, Y2, _, _, X, Y).

#show black/2.
