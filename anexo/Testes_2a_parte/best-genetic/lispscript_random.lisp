#! /usr/local/bin/clisp
;(loop for item in *args* do
;(print (parse-integer item)))

(setf valor0 (with-input-from-string (in (nth 0 *args*))(read in)))
(setf valor1 (with-input-from-string (in (nth 1 *args*))(read in)))
(setf valor2 (with-input-from-string (in (nth 2 *args*))(read in)))
(setf valor3 (with-input-from-string (in (nth 3 *args*))(read in)))
(setf tab-pos (with-input-from-string (in (nth 4 *args*))(read in)))

(setf tabuleiros (with-open-file (s "tabs_diff.txt")
  (loop with eof = '#:eof
        for object = (read s nil eof)
        until (eq object eof)
        collect object)))

(load "entregue.lisp")

;(ignore-value (setf a1 '#2A((T T T T NIL NIL T T T T)(T T T NIL NIL NIL T T T T)(T T T NIL NIL NIL T T T T)(T T T NIL NIL NIL T T T T)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL)(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL))))
(setf a1 (nth tab-pos tabuleiros))
;;;deve retornar IGNORE
;(setf r1 (procura-best a1 '(t i l l)))
;(procura-best a1 '(I S Z L))
(procura-best a1 '(t i l l))

;(dotimes (c 20)
;	(print (cria-tabuleiro-aleatorio 1 0.085)))

;(procura-best (cria-tabuleiro) (random-pecas 6))

;(time (procura-best (cria-tabuleiro-aleatorio 1 0.085) (random-pecas 8)))
;(print "lispscript execution")
;(procura-best (cria-tabuleiro-aleatorio 1 0.085) (random-pecas 4)))