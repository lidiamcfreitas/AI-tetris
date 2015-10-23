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
    (pecas-colocadas NIL))

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
	    (if (aref tabuleiro l c) 
	        (progn  (setf altura (- 18 l)) 
	        (setf l 18) ) () ))
	altura))

(defun tabuleiro-linha-completa-p(tabuleiro l)
    (let ((p T))
    (dotimes(columns 10)
        (if (aref tabuleiro l columns) () (setf p nil )))
    p))

(defun tabuleiro-preenche! (tabuleiro l c)
    (if (and (<= l 17) (<= c 9)) 
        (setf (aref tabuleiro (- 17 l) c) T)))

(defun tabuleiro-despreenche (tabuleiro l c)
    (setf (aref tabuleiro (- 17 l) c) NIL))

(defun tabuleiro-remove-linha!(tabuleiro l)
    (dotimes(c 10)
        (tabuleiro-despreenche tabuleiro l c)))

(defun tabuleiro-topo-preenchido(tabuleiro)
    (let ((p NIL) (l 17))
        (dotimes(columns 10)
            (if (aref tabuleiro l columns) 
                (progn  (setf p T ) 
                        (setf columns 10)) 
                ()))
    p)) 

(defun tabuleiros-iguais-p(tabuleiro1 tabuleiro2)
    (equalp tabuleiro1 tabuleiro2))

(defun tabuleiro->array(tabuleiro)  ; rever com professor
        (copia-tabuleiro tabuleiro))

(defun array->tabuleiro(array)      ; rever com professor
    (let ((tabuleiro NIL))
        (setf tabuleiro (copia-tabuleiro array))
        tabuleiro))


(load "utils.lisp")


;TESTING
(let ((tabuleiro NIL) (tabuleiro-novo NIL))
    (setf tabuleiro (cria-tabuleiro))
    (tabuleiro-preenche! tabuleiro 0 0)
    (setf tabuleiro-novo (copia-tabuleiro tabuleiro ))
    ;(tabuleiro-despreenche tabuleiro-novo 0 0)
    (tabuleiro-preenche! tabuleiro-novo 2 0)
    (tabuleiro-preenche! tabuleiro 2 0)
)
