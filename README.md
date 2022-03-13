# `mai`: `ma`thematics `i`nterpreter with standard foundations #

## Abstract ##

`mai` is a free and open-source tool for [computer-assisted mathematics](https://en.wikipedia.org/wiki/Proof_assistant).
It includes a comprehensive coverage of the language of mathematics and its 'standard' foundations; namely, [first-order logic](https://en.wikipedia.org/wiki/First-order_logic) and the [Zermelo–Fraenkel axioms](https://en.wikipedia.org/wiki/Zermelo%E2%80%93Fraenkel_set_theory) of set theory with [Choice](https://en.wikipedia.org/wiki/Axiom_of_choice).
Syntactic sugar for computer-assisted mathematics is included too.

A unique feature of `mai` is its simplicity – its mathematical foundations are implemented as a set of [rules of inference](https://en.wikipedia.org/wiki/Rule_of_inference) in a minimalist logical framework called `horc` (see [here](https://github.com/amka66/horc)).
This implementation directly parallels textbook definitions of logic and set theory. Therefore, it may accompany other learning materials on these topics, and may serve as a reference definition that can be executed, scrutinized, and used in practice to verify and generate formal proof.

To illustrate how `mai` is used, a formal mathematical exposition of set theory is included, with emphasis on building a powerful toolset for the working mathematician (work in progress). To try it out on any computer preinstalled with [Docker](https://en.wikipedia.org/wiki/Docker_(software)), write: `docker run --rm amka66/mai set-theory.pl`.

## Features ##

* Free and open-source [interpreter](https://en.wikipedia.org/wiki/Interpreter_(computing)) for __computer-assisted mathematics__, called `mai`, currently for educational use.
It includes:
  * [Shell](https://en.wikipedia.org/wiki/Shell_(computing)) for writing formal mathematics.
  * The capability of keeping track of theorems and definitions and verifying their validity.
  * Comprehensive coverage of the language of mathematics and its foundations.

* `mai` includes a formal and *executable* definition of the 'standard' [foundations of mathematics](https://en.wikipedia.org/wiki/Foundations_of_mathematics), including:
  * Classical [first-order logic (FOL)](https://en.wikipedia.org/wiki/First-order_logic) with equality.
  * [Natural deduction](https://en.wikipedia.org/wiki/Natural_deduction) proof system for first-order logic, used to verify and generate formal proof.
  * [FOL theories](https://en.wikipedia.org/wiki/Theory_(mathematical_logic)) and their extension by introducing new [definitions](https://en.wikipedia.org/wiki/Definition) and [theorems](https://en.wikipedia.org/wiki/Theorem).
  * [Zermelo-Fraenkel set theory with Choice (ZFC)](https://en.wikipedia.org/wiki/Zermelo%E2%80%93Fraenkel_set_theory) formalized in first-order logic.
  
* These foundations are implemented in their entirety as a set of [rules of inference](https://en.wikipedia.org/wiki/Rule_of_inference) in a minimalist logical framework called `horc` (see [here](https://github.com/amka66/horc)).
  * This implementation directly parallels textbook definitions of logic and set theory, and thus may serve as a reference definition of those topics that can be executed, 
  scrutinized, and used in practice.

  * Technically, `horc` is implemented in [Prolog](https://en.wikipedia.org/wiki/Prolog) and operates within the [SWI-Prolog](https://en.wikipedia.org/wiki/SWI-Prolog) ecosystem, and so is `mai`.

* `mai` is available as a [Docker](https://en.wikipedia.org/wiki/Docker_(software)) image hosted in [Docker Hub](https://hub.docker.com).
It requires *no* installation and can be downloaded and executed with a single command on any computer preinstalled with Docker.

* Via Prolog, `mai` supports the implementation of higher layers of automation – namely, proof tactics – without compromising the logic.

* At this point, `mai` should be considered an educational tool and proof-of-concept due to the limited number of proof tactics that are currently implemented.

## How to Execute? ##

`mai` can be automatically downloaded and executed with *no* need for local installation (nor cloning the project repository) on any computer preinstalled with [Docker](https://en.wikipedia.org/wiki/Docker_(software)).
In the command prompt, enter:

```$ docker run [-it] [--rm] [-v <local_dir>:<mount_dir>] amka66/mai [<prolog_file>]```

* `<prolog_file>` (optional): Path to a __Prolog script__ file (optionally ending with the extension `.pl`), written in ISO-compliant or SWI-Prolog-compliant Prolog.
If present, it is to contain a *formal mathematical exposition* in the form of Prolog queries to be verified in `mai`. It may possibly include other content too, intended to extend the shell, initialize an interactive Prolog session with the user, etc.
The provided path is within the container (consider option `-v` to access the host machine).
A script included in `mai` that may be used here is `set-theory.pl`, containing a formal mathematical exposition of set theory.

* `-it` (optional): Option for `docker run`, which, in our case, sets an interactive Prolog session with the user after loading and executing `<prolog_file>` (if present).

* `-v <local_dir>:<mount_dir>` (optional): Option for `docker run`, which mounts a local directory `<local_dir>` within the host machine to a specified mount point (a directory) `<mount_dir>` within the container.
The mount point may be used to refer to Prolog scripts in the host machine.

* `--rm` (optional): Option for `docker run`, which purges the container once it has stopped running.
Unless one would like to examine the container after it has stopped running, it is safe to use this option to purge obsolete containers at once.

### Examples ###

`$ docker run --rm amka66/mai set-theory.pl`  
Load and execute the included Prolog script `set-theory.pl`, containing a formal mathematical exposition of set theory to be verified with `mai`.

`$ docker run -it --rm amka66/mai`  
Start an interactive Prolog session with the user.

`$ docker run -it --rm -v ~/myfiles:/mnt amka66/mai /mnt/linear-algebra.pl`  
Load and execute a Prolog script stored locally in `~/myfiles/linear-algebra.pl`, and then start an interactive Prolog session with the user.

## Getting Started ##

* Read through [`README.md`](https://github.com/amka66/mai/blob/master/README.md) (this file).
* Install [Docker](https://en.wikipedia.org/wiki/Docker_(software)) (if missing).
* To make sure it works, have `mai` verify the included exposition of set theory by executing: `docker run --rm amka66/mai set-theory.pl`.
* As in common mathematical practice, only a fragment of the mathematical foundations underlying `mai` is typically used in formal mathematical expositions.
  * To gain working knowledge with `mai`, examine the mathematical exposition of set theory included in [`set-theory.pl`](https://github.com/amka66/mai/blob/master/src/prolog/math/set-theory.pl). The steps in the exposition consist of shell functions (defined in `zfc-shell.pl`) and the arguments of those functions consist of the concrete syntax of logical formulae (defined in `zfc-concrete.pl`).
  * Read through [`set-theory.pl`](https://github.com/amka66/mai/blob/master/src/prolog/math/set-theory.pl) for the development of powerful set-theoretical tools for the working mathematician (work in progress).
* For a comprehensive understanding of `mai` and its mathematical foundations start by learning `horc` (see [Where to Begin?](https://github.com/amka66/horc#where-to-begin)). Then:
  * Read through the definitions of the mathematical foundations of `mai` (implemented in `horc`): [`fol-1.hn`](https://github.com/amka66/mai/blob/master/src/horn/fol-1.hn), [`fol-2.hn`](https://github.com/amka66/mai/blob/master/src/horn/fol-2.hn), [`fol-3.hn`](https://github.com/amka66/mai/blob/master/src/horn/fol-3.hn), [`fol-4.hn`](https://github.com/amka66/mai/blob/master/src/horn/fol-4.hn), and [`zfc.hn`](https://github.com/amka66/mai/blob/master/src/horn/zfc.hn).
  * Read through the definitions of `mai`'s shell and concrete syntax (implemented in Prolog): [`zfc-shell.pl`](https://github.com/amka66/mai/blob/master/src/prolog/zfc-shell.pl) and [`zfc-concrete.pl`](https://github.com/amka66/mai/blob/master/src/prolog/zfc-concrete.pl).
  * The theory and the motivation behind these definitions are covered in standard texts on logic and axiomatic set theory (see [Additional Resources](https://github.com/amka66/mai#additional-resources)).

## Overview of Source Code (for developers) ##

> We invite those who share our vision to join us in making this into an industrial-strength free and open-source framework for computer-assisted mathematics.

The following is an account of the files included in the repository.

File | Directory | Description
---- | --------- | -----------
`fol-1.hn` | `src/horn` | Horn knowledge base (see `<horn_file>` in [here](https://github.com/amka66/horc#how-to-execute)) defining classical first-order logic with equality (FOL) -- both syntax, operations on syntax, and a proof system called natural deduction.
`fol-2.hn` | `src/horn` | Horn knowledge base introducing a set of admissible (derived) rules that can be used for proving theorems. Some of these are intended to support the extension of FOL theories with theorems and definitions, per `fol-3.hn` and `fol-4.hn`.
`fol-3.hn` | `src/horn` | Horn knowledge base defining a FOL theory (including a subset the language, and axioms) and the proper way to extend theories with theorems and definitions -- in case of a *finite* number of axioms (mathematical expositions of 'type I').
`fol-4.hn` | `src/horn` | Horn knowledge base defining the proper way to extend FOL theories with theorems and definitions -- in case of a possibly *infinite* number of axioms (mathematical expositions of 'type II').
`zfc.hn` | `src/horn` | Horn knowledge base defining the primitive language and axioms of the Zermelo-Fraenkel set theory with Choice (ZFC). It is a starting point for mathematical expositions of type II (per `fol-4.hn`).
`zfc-concrete.pl` | `src/prolog` | Prolog script defining concrete syntax and syntactic sugar for FOL and ZFC, and the conversion to and from abstract syntax.
`zfc-shell.pl` | `src/prolog` | Prolog script defining several shell (top-level) functions to support for mathematical expositions of type II (per `fol-4.hn`).
`set-theory.pl` | `src/prolog/math` | Prolog script containing a formal mathematical exposition of set theory in `mai` (work in progress).
`run.sh` | `src/bash` | Bash script serving only as interface. Executed first (top) when a Docker container starts, and receiving its parameters from the command line.
`create-temp-file-and-run-horc.sh` | `src/bash` | Invoked by `run.sh`, this Bash script and assembles everything together. (1) It creates a temporary Prolog script that loads `zfc-shell.pl`, and an optional Prolog script `<prolog_file>`. (2) It invokes `horc` on the knowledge base `zfc.hn` (which loads the other knowledge bases), accompanied by the temporary Prolog script from (1).
`build-docker.sh`, `run-docker.sh`, `test-docker.sh` | `bin` | Bash utility scripts for developers: building a Docker image, running a Docker image in a container, and testing a Docker image.
`Dockerfile` | `.` | Docker script for building a Docker image.
`.dockerignore` | `.` | List of files to be excluded in Dockerfile's copy command.
`.gitignore` | `.` | List of files to be excluded from Git.
`.gitattributes` | `.` | File extensions and their associated languages.
`mai.bib` | `.` | BibTeX file containing project's bibliography.
`LICENSE` | `.` | License file (plain text).
`README.md` | `.` | This file (Markdown).

## Additional Resources ##

* As a first reference on the theory of first-order logic (excluding our natural deduction proof system), which we find understandable and highly aligned with our approach, we may suggest Enderton's classic text:
[Enderton, Herbert B. A Mathematical Introduction to Logic. Academic Press, 2nd edition, 2001.](https://books.google.com/books?hl=en&lr=&id=dVncCl_EtUkC&oi=fnd&pg=PP2&dq=related:XDnmIaLEU1MJ:scholar.google.com)
Another introductory text on first-order logic, which is slightly more verbose at parts, and adopts natural deduction as its proof system, is the following:
[Van Dalen, Dirk. Logic and Structure. Springer, 5th edition, 2013.](https://books.google.com/books?hl=en&lr=&id=u0wlXPHATDcC&oi=fnd&pg=PR3)

* Our natural deduction proof system is roughly the one in Section 2.3 (natural deduction with localized hypotheses) within the following booklet, which is clearly written and concise:
[Pfenning, Frank. "Automated Theorem Proving." Material for the course Automated Theorem Proving at Carnegie Mellon University, Fall 1999, revised Spring 2004.](https://www.cs.cmu.edu/afs/.cs.cmu.edu/Web/People/fp/courses/atp/handouts/atp.pdf)
Equality predicate is introduced in Section 7.1.

* As a first reference on the Zermelo-Fraenkel set theory with Choice, which introduces a set of axioms that are similar to ours, and also develops set theory to express common mathematical concepts, we may suggest:
[Enderton, Herbert B. Elements of Set Theory. Academic press, 1977.](https://books.google.com/books?hl=en&lr=&id=JlR-Ehk35XkC&oi=fnd&pg=PP1&dq=related:IypakaTDiLwJ:scholar.google.com)

<!-- __TODO__ Add more resources (perhaps also elaborate on the existing ones), and compare to Anthony Morse's theory of sets, Metamath project, Isabelle/ZF, and Lean. -->

<!-- __TODO__ Set theory is work in progress. -->

<!-- __NOTE__ More info about `mai` and the included material may be found in commit `057ca678a1`, directory `doc`. -->

<!-- __TODO__ Add a short paper to arXiv, and include a BibTeX entry for citation. -->

## License ##

Copyright 2020–2022 Amir Kantor

Licensed under the Apache License, Version 2.0  -- see `LICENSE.txt`.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
