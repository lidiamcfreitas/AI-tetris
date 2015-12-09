# [Artificial Intelligence Tetris Game](https://fenix.tecnico.ulisboa.pt/disciplinas/IArt4517/2015-2016/1-semestre/projecto)

[![Build Status](https://travis-ci.org/lidiamcfreitas/AI-tetris.png?branch=master)](https://travis-ci.org/lidiamcfreitas/AI-tetris)

On this project we intended to implement a search algorithm able to play a variant of the game Tetris, in which the parts are known for putting on departure.

Our goal is to try to maximize the number points to the defined parts.

To simplify the game, is only allowed the player to choose the rotation and the position where the piece will fall.

Once chosen the rotation and position, the piece should fall right without any further movement.

### Introduction

The aim of the project is to write a program in ```Common Lisp```, using search techniques systematically to determine the sequence of actions in order to be able to put all the pieces and trying to maximize the number of points earned.

For this purpose it should perform various tasks ranging from the implementation of the types of data used in representation on a board until the implementation of search algorithms and heuristics to guide algorithms.

Once implemented the search algorithm, students should make a study/research analysis of the various versions of the algorithms, as well as heuristic functions implemented.

### How To Download and Compile

It is mandatory you have installed [Python 3.x.x](https://www.python.org/download/releases/3.0/) (or newer) and if you need some help on this please visit the [Python documentation](https://docs.python.org/3/).

**NOTE:** we strongly recommend you to check [CLisp](http://www.clisp.org/) for download and compile ```Common Lisp```;

#### Installing CLisp

Setting up a Common Lisp environment is not easy—we've written a tutorial to make it easy.

By the time you finish, you will have:

[CLISP](http://www.gnu.org/software/clisp/) - a Common Lisp implementation with tab completion and [scripting abilities](https://speely.wordpress.com/2010/11/27/writing-scripts-with-common-lisp/).
[Emacs](http://www.gnu.org/software/emacs/) - the preferred Lisp text editor.
[Quicklisp](https://www.quicklisp.org/beta/) - a package system similar to [CPAN](http://www.cpan.org/).

##### 1) WINDOWS

1.1) Install CLISP.
1.2) Ask CLISP where the HOME directory is located: ```(user-homedir-pathname)```. In that directory, create an empty text file called ```.clisprc.lisp```.
1.3) Modify ```YOUR_HOME/.clisprc.lisp``` to look like this.

##### 2) MAC OS X

2.1) Install Xcode.
2.2) Install MacPorts.
2.3) Install CLISP by entering ```sudo port install ffcall && sudo port install clisp +dynffi``` in a terminal.

##### 3) LINUX

3.1) Run ```sudo apt-get install clisp emacs slime```, or the appropriate install command for your particular Linux flavor.
3.2) Install Quicklisp.
3.3) Modify ```~/.clisprc.lisp``` to look like this.

###### REQUIREMENTS

Windows NT/2000/XP/Vista/7 x86/x64

Mac OS X 10.4+ Intel/PowerPC x86/x64

Linux x86/x64

#### 1ª Entrega - Testes

##### Procura-A* Versão 1

```
$ git clone https://github.com/lidiamcfreitas/AI-tetris/
$ cd AI-tetris/Relatorio_testes/Testes_1a_parte/procura-a/
$ ./lispscript.py
```

##### Procura-A* Versão 2

```
$ git clone https://github.com/lidiamcfreitas/AI-tetris/
$ cd AI-tetris/Relatorio_testes/Testes_1a_parte/procura-a-2/
$ ./lispscript.py
```

##### Procura-PP

```
$ git clone https://github.com/lidiamcfreitas/AI-tetris/
$ cd AI-tetris/Relatorio_testes/Testes_1a_parte/procura-a-pp/
$ ./lispscript.py
```

#### 2ª Entrega - Testes

##### Procura-Best Genetic

```
$ git clone https://github.com/lidiamcfreitas/AI-tetris/
$ cd AI-tetris/Relatorio_testes/Testes_2a_parte/best-genetic/
$ ./lispscript.py
```

##### Procura-Best Radom

```
$ git clone https://github.com/lidiamcfreitas/AI-tetris/
$ cd AI-tetris/Relatorio_testes/Testes_2a_parte/best-random/
$ ./lispscript.py
```

### Documentation

See the [project report]().


## Details about Lisp Enviroment


To load a source file for the Lisp environment:

```
(load <nome-ficheiro>)
```

For example:

```
> (load "projecto.lisp")

T
```

To compile a file:

```
> (compile-file "projecto")

#P"/Users/pedromatos/Desktop/projecto/projecto.fasl"

NIL

NIL
```

> Compilation should not identify warnings!

To load the last well compiled file:
```
> (load "projecto")

T
```
