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
:- dynamic(temp_module:primitive_theory/1).
:- dynamic(temp_module:theorem_inclusion_yields_alt/3).
:- dynamic(temp_module:predicate_definition_yields_alt/8).
:- dynamic(temp_module:function_definition_yields_alt/13).
:- dynamic(temp_module:function_definition_second_form_yields_alt/8).
:- dynamic(temp_module:contextually_true_with_axioms/2).

% Getters and setters
% -------------------

set(Th) :-
    nb_setval(theory, Th).
% NOTE Shouldn't be used outside this file.

get(Th) :-
    nb_getval(theory, Th).

% "Shell" functions
% -----------------

% Step: primitive theory.
primitive_constants(Xs) :-
    sugarlist2constalist(Xs, Cs),
    sugarlist2formulalist([], Fs),
    hornadd(primitive_theory(form_theory(Cs,Fs)), 100000000),
    hornadd(valid_extension_alt(form_theory(Cs,Fs)), 3),
    set(form_theory(Cs,Fs)).

% Step: theorem inclusion.
theorem(Y) :-
    get(Th),
    horn(valid_extension_alt(Th), 1),
    sugar2formula(Y, F),
    hornadd(theorem_inclusion_yields_alt(Th, F, Th2), 100000000),
    hornadd(valid_extension_alt(Th2), 3),
    set(Th2).

% Step: theorem inclusion skipping proof (!)
% NOTE The following is a variant to `theorem/1` where theorems *aren't* proved!
theorem_skip_proof(Y) :-
    true_skip_proof(Y),
    theorem(Y).

% Step: predicate definition.
definition_predicate(A, Zs, X, Y) :-
    get(Th),
    horn(valid_extension_alt(Th), 1),
    atom2predicate(A, P),
    sugarlist2variablelist(Zs, Vs),
    sugar2formula(X, F),
    sugar2formula(Y, D),
    hornadd(predicate_definition_yields_alt(Th, F, Vs, N, P, VsAsTs, D, Th2),
                                            100000000),
    hornadd(valid_extension_alt(Th2), 3),
    set(Th2).

% Step: function definition.
definition_function(A, Zs, Z, X, Z1, Y) :-
    get(Th),
    horn(valid_extension_alt(Th), 1),
    atom2function(A, Fu),
    sugarlist2variablelist(Zs, Vs),
    atom2variable(Z, V),
    sugar2formula(X, F),
    atom2variable(Z1, V1),
    sugar2formula(Y, D),
    hornadd(function_definition_yields_alt(Th, F, Vs, N, V, V1, F1, F2, Fu,
                                           VsAsTs, F3, D, Th2), 100000000),
    hornadd(valid_extension_alt(Th2), 3),
    set(Th2).

% Step: function definition, 2nd form.
definition_function_second_form(A, Zs, X, Y) :-
    get(Th),
    horn(valid_extension_alt(Th), 1),
    atom2function(A, Fu),
    sugarlist2variablelist(Zs, Vs),
    sugar2term(X, T),
    sugar2formula(Y, D),
    hornadd(function_definition_second_form_yields_alt(Th, T, Vs, N, Fu,
                                                   VsAsTs, D, Th2), 100000000),
    hornadd(valid_extension_alt(Th2), 3),
    set(Th2).

% Sub-step: contextually true with axioms.
true(Y) :-
    get(form_theory(Cs,Fs)),
    horn(valid_extension_alt(form_theory(Cs,Fs)), 1),
    sugar2formula(Y, F),
    horn(formula_for(F, Cs), 100000000),
    hornadd(contextually_true_with_axioms(Fs, F), 100000000).

% Sub-step: contextually true with axioms skipping proof (!)
% NOTE The following is a variant to `true/1` where theorems *aren't* proved!
true_skip_proof(Y) :-
    get(form_theory(Cs,Fs)),
    horn(valid_extension_alt(form_theory(Cs,Fs)), 1),
    sugar2formula(Y, F),
    horn(formula_for(F, Cs), 100000000),
    skiphornadd(contextually_true_with_axioms(Fs, F)).
