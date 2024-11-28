
%%%%%%%%%%%%%%%%%
% Your code here:
%%%%%%%%%%%%%%%%%

parse(X) :- lines(X, []).

% lines(+Input, -Rest): Parses one or more lines, potentially separated by semicolons.
lines([], []). % Base case: No more input.
lines(X, A) :-
    line(X, Y),
    colonOp(Y, Z),
    lines(Z, A).
lines(X, Y) :- % Handles a single line without a trailing semicolon.
    line(X, Y).

% line(+Input, -Rest): Parses a single line consisting of numbers separated by commas.
line(X, A) :-
    num(X, Y),
    commaOp(Y, Z),
    line(Z, A).
line(X, Y) :- % Handles a single number without a trailing comma.
    num(X, Y).

% num(+Input, -Rest): Parses a sequence of digits (a number).
num(X, Y) :-
    digit(X, Y).
num(X, Z) :-
    digit(X, Y),
    num(Y, Z).

% colonOp(+Input, -Rest): Matches a semicolon and consumes it.
colonOp([';' | T], T).

% commaOp(+Input, -Rest): Matches a comma and consumes it.
commaOp([',' | T], T).

% digit(+Input, -Rest): Matches a single digit and consumes it.
digit([X | T], T) :-
    member(X, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']).

% Example execution:
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2']).
% true.
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2', ',']).
% false.
% ?- parse(['3', '2', ',', ';', '0']).
% false.
