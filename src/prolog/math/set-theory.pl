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

:- primitive_constants(
      [(-=)!2]
   ).

% Extensionality and Subsets
% --------------------------

:- theorem_skip_proof(  % Axiom of Extensionality
      'A' .. 'B' .. (x .. x -= 'A' iff x -= 'B') implies 'A' # 'B'
   ).
:- theorem_skip_proof(
      'A' .. 'B' .. 'A' # 'B' iff (x .. x -= 'A' iff x -= 'B')
   ).

:- definition_predicate( subseteq, ['A','B'],
      x .. x -= 'A' implies x -= 'B',
      'A' .. 'B' .. subseteq!['A','B'] iff (x .. x -= 'A' implies x -= 'B')
   ).

:- definition_predicate( subsetneqq, ['A','B'],
      subseteq!['A','B'] and not 'A' # 'B',
      'A' .. 'B' .. subsetneqq!['A','B'] iff subseteq!['A','B'] and not 'A' # 'B'
   ).

:- theorem_skip_proof(
      'A' .. subseteq!['A','A']
   ).
:- theorem_skip_proof(
      'A' .. 'B' .. subseteq!['A','B'] and subseteq!['B','A'] implies 'A' # 'B'
   ).
:- theorem_skip_proof(
      'A' .. 'B' .. 'C' .. subseteq!['A','B'] and subseteq!['B','C'] implies subseteq!['A','C']
   ).

:- theorem_skip_proof(
      'A' .. 'B' .. 'A' # 'B' iff subseteq!['A','B'] and subseteq!['B','A']
   ).

% Empty Set
% ---------

:- theorem_skip_proof(  % Axiom of Empty Set
      'A' :: not (x :: x -= 'A')
   ).

:- theorem_skip_proof(
      ('A' :: not (x :: x -= 'A')) and 
      ('A' .. 'B' .. not (x :: x -= 'A') and
                     not (x :: x -= 'B') implies 'A' # 'B')
   ).

:- definition_function( emptyset, [],
      'A', not (x :: x -= 'A'),
      'B',
      not (x :: x -= emptyset@[])
   ).

:- theorem_skip_proof(
      'A' .. 'A' # emptyset@[] iff not (x :: x -= 'A')
   ).

:- theorem_skip_proof(
      'A' .. subseteq![emptyset@[],'A']
   ).

% Unordered Pairs
% ---------------

:- theorem_skip_proof(  % Axiom of Unordered Pair
      x .. y .. 'A' :: z .. z -= 'A' iff z # x or z # y
   ).

:- theorem_skip_proof(
      x .. y .. ('A' :: z .. z -= 'A' iff z # x or z # y) and
                ('A' .. 'B' .. (z .. z -= 'A' iff z # x or z # y) and
                               (z .. z -= 'B' iff z # x or z # y) implies 'A' # 'B')
   ).

:- definition_function( unordered, [x,y],
      'A', z .. z -= 'A' iff z # x or z # y,
      'B',
      x .. y .. z .. z -= unordered@[x,y] iff z # x or z # y
   ).














% NOTE The following is just a quick test of 
% `step_function_definition_second_form` (i.e., `definition_function2`).
% TODO Remove.
:- definition_function_second_form( singleton, [x],
      unordered@[x,x],
      x .. singleton@[x] # unordered@[x,x]
   ).

% Comments
% --------

% TODO Work in progress.

% TODO Must simplify work with exists_one + avoid Prolog code in math files altoghether – use a fixed interface.
% TODO Try use concrete syntax as the last layer (so shell commands are on abstract syntax) + have it flexible to include defined non-logical constants for easy writing!
