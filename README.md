# `mai`: The Math Interpreter #

## Features ##

* An [interpreter](https://en.wikipedia.org/wiki/Interpreter_(computing)) for computer-assisted mathematics, called `mai`, currently for educational use.
It includes:
  * A convenient [shell](https://en.wikipedia.org/wiki/Shell_(computing)) for writing formal mathematics.
  * The capability of keeping track of theorems and definitions, and verifying their content and structure.
  * A complete coverage of the language of mathematics and its foundations.

* `mai` includes a complete, formal, and executable definition of the standard [foundations of mathematics](https://en.wikipedia.org/wiki/Foundations_of_mathematics). This includes:
  * Classical [first-order logic (FOL)](https://en.wikipedia.org/wiki/First-order_logic) with equality.
  * A [natural deduction](https://en.wikipedia.org/wiki/Natural_deduction) proof system for first-order logic.
  * [FOL theories](https://en.wikipedia.org/wiki/Theory_(mathematical_logic)) and their extension by introducing [definitions](https://en.wikipedia.org/wiki/Definition) and proving [theorems](https://en.wikipedia.org/wiki/Theorem).
  * [Zermelo-Fraenkel set theory with Choice (ZFC)](https://en.wikipedia.org/wiki/Zermelo%E2%80%93Fraenkel_set_theory) formalized in first-order logic.
  
* Foundations of mathematics are expressed and represented in full in [Horn logic](https://en.wikipedia.org/wiki/Horn_clause) (a.k.a., 'pure' [logic programming](https://en.wikipedia.org/wiki/Logic_programming)).
  * It is flexible meta-formalism for expressing more complex formalisms.
  * Using Horn logic, which is, arguably, quite close to ordinary definitions of formal systems, we hope to *close the gap between textbook definitions of the foundations of mathematics, and its implementation on a computer!*

* `mai` is packaged within a [Docker](https://en.wikipedia.org/wiki/Docker_(software)) image hosted in [Docker Hub](https://hub.docker.com).
Therefore, it requires no installation and can be executed with a single command on any computer with Docker (in the first usage, internet connection is needed).
  * Under the hood, `mai` is implemented using the free and open-source [Horn-clause](https://en.wikipedia.org/wiki/Horn_clause) interpreter [`horc`](https://github.com/amka66/horc).
  The latter operates within a [Prolog](https://en.wikipedia.org/wiki/Prolog) environment.

* `mai` supports higher layers of automation, via Prolog, without compromising the logic.

* `horc`, and therefore `mai` too, should be considered educational tools and proof-of-concept (see [there](https://github.com/amka66/horc)).

## Who is it For? ##

> We invite others who share our vision to join us in making this into an industrial-strength free and open-source framework for computer-assisted mathematics.

## Where to Begin? ##

In order to *use* the `mai` interpreter, an understanding of our implementation of the logic and set theory is required. This is essentially the contents of this project.
`mai` is implemented using `horc`, the latter being necessary and sufficient to learn all the details of our formalization of mathematics (see [there](https://github.com/amka66/horc)).
Nevertheless, like in common mathematical practice, just a small fragment of this body of knowledge is actually used in practice -- mainly, shell syntax for writing formulae including and the conversion functions (see `src/prolog/zfc-concrete.pl`), and shell functions representing steps in a formal mathematical exposition (see `src/prolog/zfc-shell.pl`). In order to get to the bottom of things, one may consider `src/prolog/math/set-theory.pl`.

## How to Execute? ##

__TODO__ Add content.

## Overview of Source Code (for developers) ##

__TODO__ Add content.

## List of Resources ##

__TODO__ Add references.

__NOTE__ More info about `mai` and the included material may be found in commit `057ca678a1`, directory `doc`.

__TODO__ Add a short paper to arXiv, and include a BibTeX entry for citation.

__TODO__ Go over todos.

__TODO__ Spell check.

## License ##

Copyright 2020 Amir Kantor

Licensed under the Apache License, Version 2.0  -- see `LICENSE.txt`.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
