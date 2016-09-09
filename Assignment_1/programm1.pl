% Assignment 1
% Author Simon Rüegg

% daughters
female(ann).
female(lis).

% mother
female(marie).

% orphan
female(alice).

% grandmother
female(grace).

% son
male(bill).

% fahter
male(joe).

% grandfather
male(jason).

parent_of(ann, marie).
parent_of(ann, joe).
parent_of(lis, marie).
parent_of(lis, joe).
parent_of(bill, joe).
parent_of(bill, marie).

parent_of(joe, jason).
parent_of(joe, grace).

sibling_of(X, Y) :- parent_of(X, Z), parent_of(Y, Z), not(X=Y).

father_of(X, Y) :- male(Y) , parent_of(X, Y).
mother_of(X, Y) :- female(Y) , parent_of(X, Y).

grandfather_of(X, Y) :- parent_of(X, Z) , father_of(Z, Y).
grandmother_of(X, Y) :- parent_of(X, Z) , mother_of(Z, Y).