%
%   Copyright 2020 Amir Kantor
%
%   Licensed under the Apache License, Version 2.0 (the "License");
%   you may not use this file except in compliance with the License.
%   You may obtain a copy of the License at
%
%       http://www.apache.org/licenses/LICENSE-2.0
%
%   Unless required by applicable law or agreed to in writing, software
%   distributed under the License is distributed on an "AS IS" BASIS,
%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%   See the License for the specific language governing permissions and
%   limitations under the License.
%

% ___File name:___ zfc-concrete.pl

% ___File purpose:___ A Prolog script defining concrete syntax and syntactic
% sugar for FOL and ZFC, and the conversion to and from abstract syntax.

% Prolog Script
% =============

% Preliminaries
% -------------

:- style_check(+singleton).

% Concrete Syntax
% ---------------

% FOL:
:- op(650, xfy, [--, ::]). % Namely, 'for all ... holds ...' and
                           % 'there exists ... such that ...'.
:- op(645, xfy, [implies, iff]).
:- op(640, yfx, [or]).
:- op(635, yfx, [and]).
:- op(630, fy, [not]).
:- op(625, xfx, [#]). % Namely, 'equals'.
:- op(625, xfx, [!]). % Namely, 'on'.
:- op(620, xfx, [@]). % Namely, 'of'.
% ZFC:
:- op(625, xfx, [-=]). % Namely, 'in'.

% Translation of Concrete Syntax to and from Abstract Syntax
% ----------------------------------------------------------

% Arguments #1, #2 are lists. All #1, #2, #3 can be bound/unbound.
% NOTE The predicate is used because Prolog lists are constructed right to 
% left, our lists are usually left to write.
list_partition(List, LeftPartList, RightPartElem) :-
    append(LeftPartList, [RightPartElem], List).

% Arguments:
% #1 bound nonnegative integer.
% #2 unbound nonnegative binary (here and after -- a list of `0`s and `1`s of
% any length, and, in general, any order of elements including padding).
dec2bin(0, []).
dec2bin(I, B) :-
    I > 0,
    R is I mod 2,
    Q is I // 2,
    dec2bin(Q, B0),
    list_partition(B, B0, R).

% Arguments:
% #1 unbound nonnegative binary (see above).
% #2 unbound nonnegative integer.
bin2dec([], 0).
bin2dec(B, I) :-
    list_partition(B, B0, R),
    bin2dec(B0, I0),
    (R == 0; R == 1),
    I is (I0 * 2) + R.

% Arguments:
% #1 bound nonnegative binary.
% #2 bound nonnegative integer.
% #3 unbound nonnegative binary.
pad_bin(B, 0, B).
pad_bin(B, I, P) :-
    I > 0,
    I0 is I - 1,
    pad_bin([0|B], I0, P).

% Arguments:
% #1 bound nonnegative binary.
% #3 unbound nonnegative binary.
bin2bin7(B, P) :-
    length(B, I0),
    I is 7 - I0,
    I >= 0,
    pad_bin(B, I, P).

binconst_22_binary(0, zero_binary).
binconst_22_binary(1, one_binary).

bin7_22_letter([BC1,BC2,BC3,BC4,BC5,BC6,BC7|[]], 
               form_letter(B1,B2,B3,B4,B5,B6,B7)) :-
    binconst_22_binary(BC1, B1),
    binconst_22_binary(BC2, B2),
    binconst_22_binary(BC3, B3),
    binconst_22_binary(BC4, B4),
    binconst_22_binary(BC5, B5),
    binconst_22_binary(BC6, B6),
    binconst_22_binary(BC7, B7).

% Arguments:
% #1 bound nonnegative integer <= 127.
% #2 unbound letter.
dec2letter(I, L) :-
    dec2bin(I, B),
    bin2bin7(B, P),
    bin7_22_letter(P, L).

% Arguments:
% #1 bound letter.
% #2 unbound nonnegative integer <= 127.
letter2dec(L, I) :-
    bin7_22_letter(B, L),
    bin2dec(B, I).

% Arguments:
% #1 bound list of nonnegative integer <= 127.
% #2 unbound word.
declist2word([], empty_word).
declist2word(Codes, append_letter_word(W0,L)) :-
    list_partition(Codes, LeftCodes, RightCode),
    declist2word(LeftCodes, W0),
    dec2letter(RightCode, L).

% Arguments:
% #1 bound word.
% #2 unbound list of nonnegative integer <= 127.
word2declist(empty_word, []).
word2declist(append_letter_word(W0,L), Codes) :-
    word2declist(W0, LeftCodes),
    letter2dec(L, RightCode),
    list_partition(Codes, LeftCodes, RightCode).

% Arguments:
% #1 bound atom.
% #2 unbound word.
atom2word(A, W) :-
    atom(A),
    atom_codes(A, Codes),
    declist2word(Codes, W).

% Arguments:
% #1 bound word.
% #2 unbound atom.
word2atom(W, A) :-
    word2declist(W, Codes),
    atom_codes(A, Codes).

% Arguments:
% #1 bound atom.
% #2 unbound variable.
atom2variable(A, form_variable(W)) :-
    atom2word(A, W).

% Arguments:
% #1 bound variable.
% #2 unbound atom.
variable2atom(form_variable(W), A) :-
    word2atom(W, A).

% Arguments:
% #1 bound atom.
% #2 unbound function.
atom2function(A, form_function(W)) :-
    atom2word(A, W).

% Arguments:
% #1 bound function.
% #2 unbound atom.
function2atom(form_function(W), A) :-
    word2atom(W, A).

% Arguments:
% #1 bound atom.
% #2 unbound predicate.
atom2predicate(A, form_predicate(W)) :-
    atom2word(A, W).

% Arguments:
% #1 bound predicate.
% #2 unbound atom.
predicate2atom(form_predicate(W), A) :-
    word2atom(W, A).

% Arguments:
% #1 bound sugar term (or else).
% #2 unbound term (iff #1 is sugar term).
sugar2term(A, variable_term(V)) :-
    atom2variable(A, V).
sugar2term('@'(A,Sugarlist), function_term(Fu,Ts)) :-
    atom2function(A, Fu),
    sugarlist2termlist(Sugarlist, Ts).
%
% Arguments:
% #1 bound list of sugar terms (or else).
% #2 unbound list of terms (iff #1 is list of sugar terms).
sugarlist2termlist([], empty_term_list).
sugarlist2termlist(Sugarlist, append_term_term_list(Ts,T)) :-
    list_partition(Sugarlist, LeftPartSugarlist, RightPartSugar),
    sugarlist2termlist(LeftPartSugarlist, Ts),
    sugar2term(RightPartSugar, T).

% Arguments:
% #1 bound term.
% #2 unbound sugar term.
term2sugar(variable_term(V), A) :-
    variable2atom(V, A).
term2sugar(function_term(Fu,Ts), '@'(A,Sugarlist)) :-
    function2atom(Fu, A),
    termlist2sugarlist(Ts, Sugarlist).
%
% Arguments:
% #1 bound list of terms.
% #2 unbound list of sugar terms.
termlist2sugarlist(empty_term_list, []).
termlist2sugarlist(append_term_term_list(Ts,T), Sugarlist) :-
    termlist2sugarlist(Ts, LeftPartSugarlist),
    term2sugar(T, RightPartSugar),
    list_partition(Sugarlist, LeftPartSugarlist, RightPartSugar).

% Arguments:
% #1 bound sugar formula (or else).
% #2 unbound formula (iff #1 is sugar formula).
% FOL:
sugar2formula(false, false_formula).
sugar2formula(true, true_formula).
sugar2formula('#'(Sugar1,Sugar2), equals_formula(T1,T2)) :-
    sugar2term(Sugar1, T1),
    sugar2term(Sugar2, T2).
sugar2formula('!'(A,Sugarlist), predicate_formula(P,Ts)) :-
    atom2predicate(A, P),
    sugarlist2termlist(Sugarlist, Ts).
sugar2formula(not(Sugar), not_formula(F)) :-
    sugar2formula(Sugar, F).
sugar2formula(and(Sugar1,Sugar2), and_formula(F1,F2)) :-
    sugar2formula(Sugar1, F1),
    sugar2formula(Sugar2, F2).
sugar2formula(or(Sugar1,Sugar2), or_formula(F1,F2)) :-
    sugar2formula(Sugar1, F1),
    sugar2formula(Sugar2, F2).
sugar2formula(implies(Sugar1,Sugar2), implies_formula(F1,F2)) :-
    sugar2formula(Sugar1, F1),
    sugar2formula(Sugar2, F2).
sugar2formula(iff(Sugar1,Sugar2), iff_formula(F1,F2)) :-
    sugar2formula(Sugar1, F1),
    sugar2formula(Sugar2, F2).
sugar2formula('--'(A,Sugar), forall_formula(V,F)) :-
    atom2variable(A, V),
    sugar2formula(Sugar, F).
sugar2formula('::'(A,Sugar), exists_formula(V,F)) :-
    atom2variable(A, V),
    sugar2formula(Sugar, F).
% ZFC:
sugar2formula('-='(Sugar1,Sugar2), F) :-
    sugar2formula('-='![Sugar1,Sugar2], F).

% Arguments:
% #1 bound formula.
% #2 unbound sugar formula.
% FOL:
formula2sugar(false_formula, false).
formula2sugar(true_formula, true).
formula2sugar(equals_formula(T1,T2), '#'(Sugar1,Sugar2)) :-
    term2sugar(T1, Sugar1),
    term2sugar(T2, Sugar2).
% ZFC:
formula2sugar(predicate_formula(P,append_term_term_list(append_term_term_list(empty_term_list,T1),T2)),
              '-='(Sugar1,Sugar2)) :-
    atom2predicate('-=', P), % NOTE Here P is bound! % TODO
    term2sugar(T1, Sugar1),
    term2sugar(T2, Sugar2),
    !. % NOTE Needed in order to avoid multiple values for a single formula.
       % TODO Yet unverified.
% FOL:
formula2sugar(predicate_formula(P,Ts), '!'(A,Sugarlist)) :-
    predicate2atom(P, A),
    termlist2sugarlist(Ts, Sugarlist).
formula2sugar(not_formula(F), not(Sugar)) :-
    formula2sugar(F, Sugar).
formula2sugar(and_formula(F1,F2), and(Sugar1,Sugar2)) :-
    formula2sugar(F1, Sugar1),
    formula2sugar(F2, Sugar2).
formula2sugar(or_formula(F1,F2), or(Sugar1,Sugar2)) :-
    formula2sugar(F1, Sugar1),
    formula2sugar(F2, Sugar2).
formula2sugar(implies_formula(F1,F2), implies(Sugar1,Sugar2)) :-
    formula2sugar(F1, Sugar1),
    formula2sugar(F2, Sugar2).
formula2sugar(iff_formula(F1,F2), iff(Sugar1,Sugar2)) :-
    formula2sugar(F1, Sugar1),
    formula2sugar(F2, Sugar2).
formula2sugar(forall_formula(V,F), '--'(A,Sugar)) :-
    variable2atom(V, A),
    formula2sugar(F, Sugar).
formula2sugar(exists_formula(V,F), '::'(A,Sugar)) :-
    variable2atom(V, A),
    formula2sugar(F, Sugar).

% Arguments:
% #1 bound list of sugar formulae (or else).
% #2 unbound list of formulae (iff #1 is list of sugar formulae).
sugarlist2formulalist([], empty_formula_list).
sugarlist2formulalist(Sugarlist, append_formula_formula_list(Fs,F)) :-
    list_partition(Sugarlist, LeftPartSugarlist, RightPartSugar),
    sugarlist2formulalist(LeftPartSugarlist, Fs),
    sugar2formula(RightPartSugar, F).

% Arguments:
% #1 bound list of formulae.
% #2 unbound list of sugar formulae.
formulalist2sugarlist(empty_formula_list, []).
formulalist2sugarlist(append_formula_formula_list(Fs,F), Sugarlist) :-
    formulalist2sugarlist(Fs, LeftPartSugarlist),
    formula2sugar(F, RightPartSugar),
    list_partition(Sugarlist, LeftPartSugarlist, RightPartSugar).

% Arguments:
% #1 bound nonnegative integer (or else).
% #2 unbound natural (iff #1 is nonnegative integer).
integer2natural(0, zero_natural).
integer2natural(I, successor_natural(N0)) :-
    I > 0,
    I0 is I - 1,
    integer2natural(I0, N0).

% Arguments:
% #1 bound natural.
% #2 unbound nonnegative integer.
natural2integer(zero_natural, 0).
natural2integer(successor_natural(N0), I) :-
    natural2integer(N0, I0),
    I is I0 + 1.

% Arguments:
% #1 bound sugar for constant and arity (or else).
% #2, #3 unbound constant and arity, respectively (iff #1 is sugar for constant
% and arity).
sugar2consta('@'(A,I), Fu, N) :-
    atom2function(A, Fu),
    integer2natural(I, N).
sugar2consta('!'(A,I), P, N) :-
    atom2predicate(A, P),
    integer2natural(I, N).

% Arguments:
% #1, #2 bound constant and arity, respectively.
% #3 unbound sugar for constant and arity.
consta2sugar(Fu, N, '@'(A,I)) :-
    function2atom(Fu, A),
    natural2integer(N, I).
consta2sugar(P, N, '!'(A,I)) :-
    predicate2atom(P, A),
    natural2integer(N, I).

% Arguments:
% #1 bound list of sugar for NOT-NECESSARILY-DISTINCT constant and arity
% (or else).
% #2 unbound list of NOT-NECESSARILY-DISTINCT constant and arity (iff #1 is
% list of sugar for NOT-NECESSARILY-DISTINCT constant and arity).
% NOTE It doesn't precisely match the core notions (where the list must contain
% distinct pairs), but at the level of the shell this seems acceptable.
sugarlist2constalist([], empty_distinct_constant_arity_list).
sugarlist2constalist(Sugarlist,
                     append_constant_arity_distinct_constant_arity_list(Cs,C,N)) :-
    list_partition(Sugarlist, LeftPartSugarlist, RightPartSugar),
    sugarlist2constalist(LeftPartSugarlist, Cs),
    sugar2consta(RightPartSugar, C, N).
    %not_member_of_distinct_constant_arity_list(C, N, Cs). % NOTE Cannot use Horn-logic clause here.

% Arguments:
% #1 bound list of NOT-NECESSARILY-DISTINCT constant and arity.
% #2 unbound list of sugar for NOT-NECESSARILY-DISTINCT constant and arity.
% NOTE It doesn't precisely match the core notions (where the list must contain
% distinct pairs), but at the level of the shell this seems acceptable.
constalist2sugarlist(empty_distinct_constant_arity_list, []).
constalist2sugarlist(append_constant_arity_distinct_constant_arity_list(Cs,C,N),
                     Sugarlist) :-
    constalist2sugarlist(Cs, LeftPartSugarlist),
    consta2sugar(C, N, RightPartSugar),
    list_partition(Sugarlist, LeftPartSugarlist, RightPartSugar).

% Arguments:
% #1 bound list of sugar for NOT-NECESSARILY-DISTINCT variables (or else).
% #2 unbound list of NOT-NECESSARILY-DISTINCT variables (iff #1 is list of 
% sugar for NOT-NECESSARILY-DISTINCT variables).
% NOTE It doesn't precisely match the core notions (where the list must contain
% distinct variables), but at the level of the shell this seems acceptable.
sugarlist2variablelist([], empty_distinct_variable_list).
sugarlist2variablelist(Sugarlist, append_variable_distinct_variable_list(Vs,V)) :-
    list_partition(Sugarlist, LeftPartSugarlist, RightPartSugar),
    sugarlist2variablelist(LeftPartSugarlist, Vs),
    atom2variable(RightPartSugar, V).
    %not_member_of_distinct_variable_list(V, Vs). % NOTE Cannot use Horn-logic clause here. 

% Arguments:
% #1 bound list of NOT-NECESSARILY-DISTINCT variables.
% #2 unbound list of sugar for NOT-NECESSARILY-DISTINCT variables.
% NOTE It doesn't precisely match the core notions (where the list must contain
% distinct variables), but at the level of the shell this seems acceptable.
variablelist2sugarlist(empty_distinct_variable_list, []).
variablelist2sugarlist(append_variable_distinct_variable_list(Vs,V),
                       Sugarlist) :-
    variablelist2sugarlist(Vs, LeftPartSugarlist),
    variable2atom(V, RightPartSugar),
    list_partition(Sugarlist, LeftPartSugarlist, RightPartSugar).

% Comments
% --------

% TODO Script is not sufficiently tested.

% TODO Rename some of the predicates and avoid the 'sugar2...' and 
% 'sugarlist2...' convention, which is ugly.
