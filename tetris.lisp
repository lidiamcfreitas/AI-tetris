; GRUPO 29
;
;
; Bruno Cardoso
; 72619
;
; Francisco Maria Calisto
; 70916
;
; Lidia Carvalho de Freitas
; 78559
;


; (load "examples.fas")
; (load "my-test.lisp")

; ======================================================================================= ;
;                               DEFINICAO DAS ESTRUTURAS DE DADOS                         ;
; ======================================================================================= ;


(defstruct estado
  (pontos 0)
  (pecas-por-colocar NIL)
  (pecas-colocadas NIL)
  (tabuleiro NIL))

(defstruct problema
  (estado-inicial NIL)
  (solucao NIL)
  (accoes NIL)
  (resultado NIL)
  (custo-caminho NIL))


; ======================================================================================= ;
; ======================================================================================= ;
;                                                                                         ;
;                                  PROJECT | FIRST PART                                   ;
;                                                                                         ;
; ======================================================================================= ;
; ======================================================================================= ;


; ======================================================================================= ;
;                                        TIPO RESTRICAO                                   ;
; ======================================================================================= ;

(defun accao (coluna peca)
  (cons coluna peca))

(defun cria-accao (int array_pecas)
  (accao int array_pecas))

(defun accao-coluna (acc)
  (car acc))

(defun accao-peca (acc)
  (cdr acc))

(defun cria-tabuleiro ()
  (let ((lines 18) (columns 10))
    (defparameter board (make-array (list lines columns)))
    (dotimes (i lines)
      (dotimes (j columns)
        (setf (aref board i j) NIL)))
    board))

(defun copia-tabuleiro(tabuleiro-arg)
  (let ((linhas 18) (colunas 10))
    (defparameter tabuleiro-novo (make-array (list linhas colunas)))
    (dotimes (i linhas)
      (dotimes (j colunas)
        (setf (aref tabuleiro-novo i j) (aref tabuleiro-arg i j))))
    tabuleiro-novo))

(defun tabuleiro-preenchido-p (tabuleiro l c) 
  (aref tabuleiro l c))

(defun tabuleiro-altura-coluna(tabuleiro c)
  (let ((altura 0))
    (dotimes(l 18)
      (when (aref tabuleiro l c) 
        (setf altura (- 17 l)) 
        (return))
      altura)))

(defun tabuleiro-linha-completa-p(tabuleiro l)
  (let ((p T))
    (dotimes(columns 10)
      (when (not(aref tabuleiro (- 17 l) columns))
        (setf p NIL)
        (return))
      p)))

(defun tabuleiro-preenche! (tabuleiro l c)
  (if (and (<= l 17) (<= c 9)) 
    (setf (aref tabuleiro (- 17 l) c) T)))

(defun tabuleiro-despreenche (tabuleiro l c)
  (setf (aref tabuleiro (- 17 l) c) NIL))

(defun tabuleiro-remove-linha!(tabuleiro l)
  (dotimes(c 10)
    (tabuleiro-despreenche tabuleiro l c)))

(defun tabuleiro-topo-preenchido(tabuleiro)
  (dotimes(columns 10 NIL)
    (when (aref tabuleiro 0 columns)
      ;(setf p T)
      (return T))
    ))

(defun tabuleiros-iguais-p(tabuleiro1 tabuleiro2)
  (equalp tabuleiro1 tabuleiro2))

(defun tabuleiro->array(tabuleiro)  ; rever com professor
  (copia-tabuleiro tabuleiro))

(defun array->tabuleiro(array)      ; rever com professor
  (let ((tabuleiro NIL))
    (setf tabuleiro (copia-tabuleiro array))
    tabuleiro))

(defun cria-estado(p ppc pc tab)
  (make-estado :pontos p :pecas-por-colocar ppc :pecas-colocadas pc :tabuleiro tab))

(defun copia-estado(eo)
  (cria-estado (estado-pontos eo) 
               (estado-pecas-por-colocar eo) 
               (estado-pecas-colocadas eo) 
               (estado-tabuleiro eo)))

(defun estados-iguais-p(estado1 estado2)
  (and (eql(estado-pontos estado1)(estado-pontos estado2)) 
       (eql(estado-pecas-por-colocar estado1)(estado-pecas-por-colocar estado2))
       (eql(estado-pecas-colocadas estado1)(estado-pecas-colocadas estado2))
       (eql(estado-tabuleiro estado1) (estado-tabuleiro estado2))))

(defun estado-final-p(estado)
  (or(tabuleiro-topo-preenchido (estado-tabuleiro estado)) 
    (eql(estado-pecas-por-colocar estado) 0)))

(defun solucao(estado)
  (and(not(tabuleiro-topo-preenchido (estado-tabuleiro estado))) 
      (eql(estado-pecas-por-colocar estado) 0)))



(load "utils.lisp")

;TESTING
(defun teste()

  (let ((tabuleiro22 NIL)
        (tabuleiro NIL) 
        (tabuleiro-novo NIL)
        (estado1 NIL)
        (estado2 NIL))

    ;(setf tabuleiro22 (cria-tabuleiro))
    ;(tabuleiro-preenche! tabuleiro22 17 0)
    ;(tabuleiro-topo-preenchido tabuleiro22)

    (setf tabuleiro (cria-tabuleiro))
    (tabuleiro-preenche! tabuleiro 17 0)
    ;(setf tabuleiro-novo (copia-tabuleiro tabuleiro ))
    ;(tabuleiro-despreenche tabuleiro-novo 0 0)
    ;(tabuleiro-preenche! tabuleiro-novo 0 0)
    ;(setf estado1 (cria-estado 100 0 2 (copia-tabuleiro tabuleiro-novo)))
    (setf estado2 (cria-estado 100 2 2 (copia-tabuleiro tabuleiro)))
    (solucao estado2)
    ;(solucao estado1)
    ))
