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

% ___File name:___ zfc-shell.pl

% ___File purpose:___ A Prolog script defining several shell (top-level) 
% functions to support for mathematical expositions of type II (per 
% `fol-4.hn`).

% Prolog Script
% =============

% Preliminaries
% -------------

:- ensure_loaded('/app/mai/src/prolog/zfc-concrete.pl').

:- style_check(-singleton).

% Declare dynamic predicates to allow `hornadd/2` and `skiphornadd/1`:
:- dynamic(temp_module:valid_extension_alt/1).
:- dynamic(temp_module:contextually_true_with_axioms/2).
:- dynamic(temp_module:primitive_theory/1).
:- dynamic(temp_module:theorem_inclusion_yields_alt/3).
:- dynamic(temp_module:predicate_definition_yields_alt/8).
:- dynamic(temp_module:function_definition_yields_alt/13).
:- dynamic(temp_module:function_definition_second_form_yields_alt/8).

% Getters and setters
% -------------------

set(Th) :-
    nb_setval(theory, Th).
% NOTE Shouldn't be used outside this file.

set(Xs, Ys) :-
    sugarlist2constalist(Xs, Cs),
    sugarlist2formulalist(Ys, Fs),
    set(form_theory(Cs,Fs)).
% NOTE Shouldn't be used outside this file.

get(Th) :-
    nb_getval(theory, Th).

get(Xs, Ys) :-
    get(form_theory(Cs,Fs)),
    constalist2sugarlist(Cs, Xs),
    formulalist2sugarlist(Fs, Ys).

% "Shell" functions
% -----------------

% Step: primitive theory.
prim(Xs) :-
    sugarlist2constalist(Xs, Cs),
    sugarlist2formulalist([], Fs),
    hornadd(primitive_theory(form_theory(Cs,Fs)), 100000000),
    hornadd(valid_extension_alt(form_theory(Cs,Fs)), 3),
    set(form_theory(Cs,Fs)).

% Step: theorem inclusion.
thm(Y) :-
    get(Th),
    sugar2formula(Y, F),
    hornadd(theorem_inclusion_yields_alt(Th, F, Th2), 100000000),
    hornadd(valid_extension_alt(Th2), 3),
    set(Th2).

% Sub-step: contextually true with axioms.
true(Y) :-
    get(form_theory(Cs,Fs)),
    sugar2formula(Y, F),
    hornadd(contextually_true_with_axioms(Fs, F), 100000000).

% NOTE The following is a variant to `true/1` where theorems *aren't* proved!
% Sub-step: skip contextually true with axioms.
skip_true(Y) :-
    get(form_theory(Cs,Fs)),
    sugar2formula(Y, F),
    horn(formula_list(Fs), 100000000),
    horn(formula(F), 100000000),
    skiphornadd(contextually_true_with_axioms(Fs, F)).

% NOTE The following is a variant to `thm` where theorems *aren't* proved!
% Step: skip contextually true with axioms and theorem inclusion.
thm_skip_true(Y) :-
    skip_true(Y),
    thm(Y).

% Step: predicate definition.
defn_p(Y, A, Zs, X) :-
    get(Th),
    sugar2formula(Y, D),
    atom2predicate(A, P),
    sugarlist2variablelist(Zs, Vs),
    sugar2formula(X, F),
    hornadd(predicate_definition_yields_alt(Th, F, Vs, N, P, VsAsTs, D, Th2),
                                            100000000),
    hornadd(valid_extension_alt(Th2), 3),
    set(Th2).

% Step: function definition.
defn_f(Y, A, Zs, Z, X, Z1) :-
    get(Th),
    sugar2formula(Y, D),
    atom2function(A, Fu),
    sugarlist2variablelist(Zs, Vs),
    atom2variable(Z, V),
    sugar2formula(X, F),
    atom2variable(Z1, V1),
    hornadd(function_definition_yields_alt(Th, F, Vs, N, V, V1, F1, F2, Fu,
                                           VsAsTs, F3, D, Th2), 100000000),
    hornadd(valid_extension_alt(Th2), 3),
    set(Th2).

% Step: function definition, 2nd form.
defn_f2(Y, A, Zs, X) :-
    get(Th),
    sugar2formula(Y, D),
    atom2function(A, Fu),
    sugarlist2variablelist(Zs, Vs),
    sugar2term(X, T),
    hornadd(function_definition_second_form_yields_alt(Th, T, Vs, N, Fu,
                                                   VsAsTs, D, Th2), 100000000),
    hornadd(valid_extension_alt(Th2), 3),
    set(Th2).
