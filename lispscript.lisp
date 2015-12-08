#! /usr/local/bin/clisp
;(loop for item in *args* do
;(print (parse-integer item)))

(setf valor0 (with-input-from-string (in (nth 0 *args*))(read in)))
(setf valor1 (with-input-from-string (in (nth 1 *args*))(read in)))
(setf valor2 (with-input-from-string (in (nth 2 *args*))(read in)))
(setf valor3 (with-input-from-string (in (nth 3 *args*))(read in)))
(setf valor4 )

(load "entregue.lisp")
;(load "utils.lisp")

(ignore-value (setf a1 '#2A((T T T T NIL NIL T T T T)(T T T NIL NIL NIL T T T T)(T T T NIL NIL NIL T T T T)(T T T NIL NIL NIL T T T T)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL))))
;;;deve retornar IGNORE
;(setf r1 (procura-best a1 '(t i l l)))
;(procura-best a1 '(t i l l))

;(dotimes (c 20)
;	(print (cria-tabuleiro-aleatorio 1 0.085)))

;(procura-best (cria-tabuleiro) (random-pecas 6))

;(time (procura-best (cria-tabuleiro-aleatorio 1 0.085) (random-pecas 8)))

(procura-best (cria-tabuleiro-aleatorio 1 0.085) (random-pecas 6))