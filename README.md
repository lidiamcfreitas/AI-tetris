# Artificial Intelligence Tetris Game

On this project we intended to implement a search algorithm able to play a variant of the game Tetris, in which the parts are known for putting on departure.

Our goal is to try to maximize the number points to the defined parts.

To simplify the game, is only allowed the player to choose the rotation and the position where the piece will fall.

Once chosen the rotation and position, the piece should fall right without any further movement.

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
