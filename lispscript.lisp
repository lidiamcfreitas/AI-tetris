#! /usr/local/bin/clisp
;(loop for item in *args* do
;(print (parse-integer item)))

(setf valor0 (with-input-from-string (in (nth 0 *args*))(read in)))
(setf valor1 (with-input-from-string (in (nth 1 *args*))(read in)))
(setf valor2 (with-input-from-string (in (nth 2 *args*))(read in)))
(setf valor3 (with-input-from-string (in (nth 3 *args*))(read in)))

(load "final.lisp")
(load "utils.lisp")

(setf real-initial (get-internal-real-time))
(setf retorno (time (print (procura-best (cria-tabuleiro-aleatorio 1 0.085) (random-pecas 8)))))
(setf real-final (get-internal-real-time))
(print "por diferencas:")
  (print (- real-initial real-final))

