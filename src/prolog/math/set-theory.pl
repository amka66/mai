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

% ___File name:___ set-theory.hn

% ___File purpose:___ A Prolog script containing a formal mathematical 
% exposition of set theory in mai.

% Prolog Script
% =============

% Primitives
% ----------

:- prim([(-=)!2]).

% Extensionality and Subsets
% --------------------------

:- thm_skip_true('A' -- 'B' -- (x -- x -= 'A' iff x -= 'B') implies 
                               'A' # 'B'). % Axiom.

:- thm_skip_true('A' -- 'B' -- 'A' # 'B' iff (x -- x -= 'A' iff x -= 'B')).

:- defn_p('A' -- 'B' -- subseteq!['A','B'] iff (x -- x -= 'A' implies 
                                                     x -= 'B'),
          subseteq, 
          ['A','B'],
          x -- x -= 'A' implies x -= 'B').

:- defn_p('A' -- 'B' -- subsetneq!['A','B'] iff subseteq!['A','B'] and 
                                                not 'A' # 'B',
          subsetneq, 
          ['A','B'],
          subseteq!['A','B'] and not 'A' # 'B').

:- thm_skip_true('A' -- subseteq!['A','A']).

:- thm_skip_true('A' -- 'B' -- subseteq!['A','B'] and subseteq!['B','A'] 
                               implies 'A' # 'B').

:- thm_skip_true('A' -- 'B' -- 'C' -- subseteq!['A','B'] and subseteq!['B','C'] 
                                      implies subseteq!['A','C']).

:- thm_skip_true('A' -- 'B' -- 'A' # 'B' iff subseteq!['A','B'] and 
                                             subseteq!['B','A']).

% Empty Set
% ---------

:- thm_skip_true('A' :: not (x :: x -= 'A')). % Axiom.

:- Y = ('A' :: not (x :: x -= 'A')) and 
       ('A' -- 'B' -- not (x :: x -= 'A') and 
                      not (x :: x -= 'B') implies 'A' # 'B'),
   sugar2formula(Y, F1),
   atom2variable('A', V),
   sugar2formula(not (x :: x -= 'A'), F),
   atom2variable('B', V1),
   horn(exists_one_formula_is(V, F, V1, F1), 100000000),
   formula2sugar(F1, Y),
   thm_skip_true(Y).

:- defn_f(not (x :: x -= emptyset@[]),
          emptyset,
          [],
          'A',
          not (x :: x -= 'A'),
          'B').

:- thm_skip_true('A' -- 'A' # emptyset@[] iff not (x :: x -= 'A')).

:- thm_skip_true('A' -- subseteq![emptyset@[],'A']).

% Unordered Pairs

:- thm_skip_true(x -- y -- 'A' :: z -- z -= 'A' iff z # x or z # y). % Axiom.

:- atom2variable('A', V),
   sugar2formula(z -- z -= 'A' iff z # x or z # y, F),
   atom2variable('B', V1),
   horn(exists_one_formula_is(V, F, V1, F1), 100000000),
   formula2sugar(F1, Y),
   thm_skip_true(x -- y -- Y).

:- defn_f(x -- y -- z -- z -= unordered@[x,y] iff z # x or z # y,
          unordered,
          [x,y],
          'A',
          z -- z -= 'A' iff z # x or z # y,
          'B').

% NOTE The following is just a quick test of 
% `step_function_definition_second_form` (i.e., `defn_f2`).
% TODO Remove.
:- defn_f2(x -- singleton@[x] # unordered@[x,x],
           singleton,
           [x],
           unordered@[x,x]).

% Comments
% --------

% TODO Work in progress.
