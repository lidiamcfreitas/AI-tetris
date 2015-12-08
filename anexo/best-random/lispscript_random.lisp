#! /usr/local/bin/clisp
; recebe como argumentos os valores dos pesos das heuristicas e o
; numero do tabuleiro a aceder.
(setf valor0 (with-input-from-string (in (nth 0 *args*))(read in)))
(setf valor1 (with-input-from-string (in (nth 1 *args*))(read in)))
(setf valor2 (with-input-from-string (in (nth 2 *args*))(read in)))
(setf valor3 (with-input-from-string (in (nth 3 *args*))(read in)))
(setf tab-pos (with-input-from-string (in (nth 4 *args*))(read in)))

; vai buscar todos os tabuleiros que estao no ficheiro "tabs_diff.txt"
; e guarda-os.
(setf tabuleiros (with-open-file (s "tabs_diff.txt")
  (loop with eof = '#:eof
        for object = (read s nil eof)
        until (eq object eof)
        collect object)))

(load "entregue.lisp")

; acede ao tabuleiro que esta na posicao tab-pos
(setf a1 (nth tab-pos tabuleiros))
; realiza a procura-best com 4 pecas e o tabuleiro acima referido.
(procura-best a1 '(t i l l))