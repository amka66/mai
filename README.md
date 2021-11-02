# `mai`: Math Interpreter with Standard Foundations #

## Abstract ##

A free and open-source [proof assistant](https://en.wikipedia.org/wiki/Proof_assistant) for general mathematics.
Building on [__`horc`__](https://github.com/amka66/horc), it allows both verifying and generating formal mathematics.
`mai` includes a comprehensive coverage of the language of mathematics and its 'standard' foundations; namely, [first-order logic](https://en.wikipedia.org/wiki/First-order_logic) and the [Zermelo–Fraenkel axioms](https://en.wikipedia.org/wiki/Zermelo%E2%80%93Fraenkel_set_theory) of set theory with [Choice](https://en.wikipedia.org/wiki/Axiom_of_choice).
Syntactic sugar for computer-assisted mathematics is included too.
To illustrate how `mai` is used in practice, an exposition of set theory is included, with emphasis on building a powerful toolset for the working mathematician (work in progress).

## Features ##

* A free and open-source [interpreter](https://en.wikipedia.org/wiki/Interpreter_(computing)) for __computer-assisted mathematics__, called `mai`, currently for educational use.
It includes:
  * A [shell](https://en.wikipedia.org/wiki/Shell_(computing)) for writing formal mathematical expositions.
  * The capability of keeping track of theorems and definitions, and verifying their content and structure.
  * Comprehensive coverage of the language of mathematics and its foundations.

* `mai` includes a complete, formal, and *executable* definition of the standard [foundations of mathematics](https://en.wikipedia.org/wiki/Foundations_of_mathematics), including:
  * Classical [first-order logic (FOL)](https://en.wikipedia.org/wiki/First-order_logic) with equality.
  * A [natural deduction](https://en.wikipedia.org/wiki/Natural_deduction) proof system for first-order logic.
  * [FOL theories](https://en.wikipedia.org/wiki/Theory_(mathematical_logic)) and their extension by writing [definitions](https://en.wikipedia.org/wiki/Definition) and proving [theorems](https://en.wikipedia.org/wiki/Theorem).
  * [Zermelo-Fraenkel set theory with Choice (ZFC)](https://en.wikipedia.org/wiki/Zermelo%E2%80%93Fraenkel_set_theory) formalized in first-order logic.
  
* The foundations of mathematics are expressed and represented in full in [Horn logic](https://en.wikipedia.org/wiki/Horn_clause) (a.k.a., 'pure' [logic programming](https://en.wikipedia.org/wiki/Logic_programming)).
  * A minimalist meta-formalism for expressing more complex formalisms.

* `mai` is packaged within a [Docker](https://en.wikipedia.org/wiki/Docker_(software)) image hosted in [Docker Hub](https://hub.docker.com).
Therefore, it requires no installation and can be executed with a single command on any computer with Docker (in the first usage, internet connection is needed).
  * Under the hood, `mai` is implemented using the free and open-source [Horn-clause](https://en.wikipedia.org/wiki/Horn_clause) interpreter `horc` (see [here](https://github.com/amka66/horc)).
  The latter operates within a [Prolog](https://en.wikipedia.org/wiki/Prolog) environment.

* `mai` supports higher layers of automation, via Prolog, without compromising the logic.

* Both `horc` and `mai` should be considered educational tools and proof-of-concept (see [here](https://github.com/amka66/horc)).

## Who is it For? ##

> We invite others who share our vision to join us in making this into an industrial-strength free and open-source framework for computer-assisted mathematics.

## Where to Begin? ##

In order to *use* the `mai` interpreter, an understanding of our implementation of logic and set theory is required. This is essentially the contents of this project.
Specifically, `mai` is implemented using `horc`, so an understanding of the latter is necessary and sufficient in order to learn all the details of our formalization of mathematics (see [Where to Begin?](https://github.com/amka66/horc#where-to-begin)). The theory and the motivation behind these definitions, in contrast, are covered in standard texts on logic and set theory. A list of resources is included in the following.

Nevertheless, like in common mathematical practice, just a small fragment of this body of knowledge is actually used in practice. This mainly includes concrete syntax for writing formulae (and the conversion functions that accompany it; see `src/prolog/zfc-concrete.pl`), as well as shell functions that represent steps in a formal mathematical exposition (see `src/prolog/zfc-shell.pl`). An example of a mathematical exposition is included in `src/prolog/math/set-theory.pl`.

## How to Execute? ##

If you have [Docker](https://en.wikipedia.org/wiki/Docker_(software)) on your computer, `mai` can be automatically downloaded and executed with *no* need for local installation (nor cloning the project repository).
In the command prompt, simply enter the following:

```$ docker container run [-it] [--rm] [-v <local_dir>:<container_dir> ...] <docker_hub_user_id>/mai [<prolog_file>]```

* `<docker_hub_user_id>` (mandatory): User ID in Docker Hub that currently stores the docker image.
Use `amka66`. __TODO__ Upload image!

* `<prolog_file>` (optional): Path to a __Prolog script__ file (optionally ending with the extension `.pl`), written in ISO-compliant or SWI-Prolog-compliant Prolog.
If present, it is to contain a *formal mathematical exposition* in the form of Prolog queries, and possibly other content intended to extend the shell, initialize an interactive Prolog session with the user, etc.
The path is within the container (consider option `-v` below to access the host machine).
Included script that can be used here: `set-theory.pl`, containing a formal mathematical exposition of set theory.

* `-it` (optional): Option for `docker container run`, which, in our case, sets an interactive Prolog session with the user, after loading and executing `<prolog_file>` (if present).

* `-v <local_dir>:<container_dir> ...` (optional): Option for `docker container run`, which mounts a local directory (within the host machine) to a specified mount point (directory) within the container.
The mount point should be used for referring to Prolog scripts in the host machine, as all prescribed paths are within the container. Note that a list of such pairs can be given.

* `--rm` (optional): Option for `docker container run`, which purges the container once it has stopped running.
Unless you would like to examine the container after it has stopped, it is safe to use this option and avoid keeping obsolete containers.

### Examples ###

`$ docker container run --rm amka66/mai set-theory.pl`  
Load and execute the included Prolog script `set-theory.pl`, containing a formal mathematical exposition of set theory.

`$ docker container run -it --rm amka66/mai`  
Start an interactive Prolog session with the user.

`$ docker container run -it --rm -v ~/my-files:/mount amka66/mai /mount/linear-algebra.pl`  
Load and execute a Prolog script stored locally in `~/my-files/linear-algebra.pl`, and start an interactive Prolog session with the user.

## Overview of Source Code ##

The following is an account of all files in the repository.

File | Directory | Description
---- | --------- | -----------
`fol-1.hn` | `src/horn` | A Horn knowledge base (see `<horn_file>` in [here](https://github.com/amka66/horc#how-to-execute)) defining classical first-order logic with equality (FOL) -- both syntax, operations on syntax, and a proof system called natural deduction.
`fol-2.hn` | `src/horn` | A Horn knowledge base introducing a set of admissible (derived) rules that can be used for proving theorems. Some of these are intended to support the extension of FOL theories with theorems and definitions, per `fol-3.hn` and `fol-4.hn`.
`fol-3.hn` | `src/horn` | A Horn knowledge base defining a FOL theory (including a subset the language, and axioms) and the proper way to extend theories with theorems and definitions -- in case of a *finite* number of axioms (mathematical expositions of 'type I').
`fol-4.hn` | `src/horn` | A Horn knowledge base defining the proper way to extend FOL theories with theorems and definitions -- in case of a possibly *infinite* number of axioms (mathematical expositions of 'type II').
`zfc.hn` | `src/horn` | A Horn knowledge base defining the primitive language and axioms of the Zermelo-Fraenkel set theory with Choice (ZFC). It is a starting point for mathematical expositions of type II (per `fol-4.hn`).
`zfc-concrete.pl` | `src/prolog` | A Prolog script defining concrete syntax and syntactic sugar for FOL and ZFC, and the conversion to and from abstract syntax.
`zfc-shell.pl` | `src/prolog` | A Prolog script defining several shell (top-level) functions to support for mathematical expositions of type II (per `fol-4.hn`).
`set-theory.pl` | `src/prolog/math` | A Prolog script containing a formal mathematical exposition of set theory in `mai`. __TODO__ Work in progress.
`run.sh` | `src/bash` | Bash script serving only as interface. Executed first (top) when a Docker container starts, and receiving its parameters from the command line.
`create-temp-file-and-run-horc.sh` | `src/bash` | Invoked by `run.sh`, this Bash script and assembles everything together. (1) It creates a temporary Prolog script that loads `zfc-shell.pl`, and an optional Prolog script `<prolog_file>`. (2) It invokes `horc` on the knowledge base `zfc.hn` (which loads the other knowledge bases), accompanied by the temporary Prolog script from (1).
`build-docker.sh`, `run-docker.sh`, `test-docker.sh` | `bin` | Bash utility scripts for developers: building a Docker image, running a Docker image in a container, and testing a Docker image.
`Dockerfile` | `.` | Docker script for building a Docker image.
`.dockerignore` | `.` | A list of files to be excluded in Dockerfile's copy command.
`.gitignore` | `.` | A list of files to be excluded from Git.
`.gitattributes` | `.` | File extensions with their associated languages.
`mai.bib` | `.` | BibTeX file containing project's bibliography.
`LICENSE` | `.` | License file (plain text).
`README.md` | `.` | This file (Markdown).

## List of Resources ##

* The `horc` project (see [here](https://github.com/amka66/horc#how-to-execute)) is our formal foundations.

* As a first resource on the theory of first-order logic (excluding our natural deduction proof system), which we find understandable and highly aligned with our approach, we may suggest Enderton's classic text:
[Enderton, Herbert B. A Mathematical Introduction to Logic. Academic Press, 2nd edition, 2001.](https://books.google.com/books?hl=en&lr=&id=dVncCl_EtUkC&oi=fnd&pg=PP2&dq=related:XDnmIaLEU1MJ:scholar.google.com)
Another introductory text on first-order logic, which is slightly more verbose at parts, and adopts natural deduction as its proof system, is the following:
[Van Dalen, Dirk. Logic and Structure. Springer, 5th edition, 2013.](https://books.google.com/books?hl=en&lr=&id=u0wlXPHATDcC&oi=fnd&pg=PR3)

* Our natural deduction proof system is roughly the one in Section 2.3 (natural deduction with localized hypotheses) within the following booklet, which is clearly written and concise:
[Pfenning, Frank. "Automated Theorem Proving." Material for the course Automated Theorem Proving at Carnegie Mellon University, Fall 1999, revised Spring 2004.](https://www.cs.cmu.edu/afs/.cs.cmu.edu/Web/People/fp/courses/atp/handouts/atp.pdf)
Equality predicate is introduced in Section 7.1.

* As a first resource on the Zermelo-Fraenkel set theory with Choice, which introduces a set of axioms that are similar to ours, and also develops set theory to express common mathematical concepts, we may suggest:
[Enderton, Herbert B. Elements of Set Theory. Academic press, 1977.](https://books.google.com/books?hl=en&lr=&id=JlR-Ehk35XkC&oi=fnd&pg=PP1&dq=related:IypakaTDiLwJ:scholar.google.com)

__TODO__ Add more resources (perhaps also elaborate on the existing ones), and compare to Anthony Morse's theory of sets, Metamath project, and Isabelle/ZF.

__NOTE__ More info about `mai` and the included material may be found in commit `057ca678a1`, directory `doc`.

__TODO__ Add a short paper to arXiv, and include a BibTeX entry for citation.

__TODO__ Go over todos.

## License ##

Copyright 2020 Amir Kantor

Licensed under the Apache License, Version 2.0  -- see `LICENSE.txt`.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
