female(ann).
female(lis).
female(marie).

male(joe).
male(bill).
male(jason).

mother_of(ann, marie).
father_of(ann, joe).

mother_of(lis, marie).
father_of(lis, joe).

father_of(joe, jason).

parent_of(X, Y) :- mother_of(X, Y) ; father_of(X, Y).

grandfather_of(X, Y) :- father_of(X, Z) , father_of(Z, Y).