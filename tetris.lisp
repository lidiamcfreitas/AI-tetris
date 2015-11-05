; GRUPO 29 - (insere-alunos (cria-aluno Bruno Cardoso 72619) (cria-aluno Francisco Calisto 70916) (cria-aluno Lidia Freitas 78559))


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

;(load (compile-file "utils.lisp"))
;(load "utils.lisp")

(defun cria-accao (coluna peca)
  (cons coluna peca))

(defun accao-coluna (acc)
  (car acc))

(defun accao-peca (acc)
  (cdr acc))

(defun cria-tabuleiro ()
  (let ((lines 18) (board nil) (columns 10))
    (setf board (make-array (list lines columns)))
    (dotimes (i lines)
      (dotimes (j columns)
        (setf (aref board i j) NIL)))
    board))

(defun copia-tabuleiro(tabuleiro-arg)
  (let ((linhas 18)(tabuleiro-novo nil) (colunas 10))
    (setf tabuleiro-novo (make-array (list linhas colunas)))
    (dotimes (i linhas)
      (dotimes (j colunas)
        (setf (aref tabuleiro-novo i j) (aref tabuleiro-arg i j))))
    tabuleiro-novo))

(defun tabuleiro-preenchido-p (tabuleiro l c) 
  (aref tabuleiro (- 17 l) c))

(defun tabuleiro-altura-coluna(tabuleiro c)
  (let ((altura 0))
    (dotimes(l 18)
      (when (aref tabuleiro l c) 
        (setf altura (- 18 l)) 
        (return)))
    altura))

(defun tabuleiro-linha-completa-p(tabuleiro l)
  (let ((retorno T))  
    (dotimes (columns 10)
      ;(format t "~a ~a ~a"  retorno l columns)
      (when (not (tabuleiro-preenchido-p tabuleiro l columns))
        (setf retorno NIL)
        (return)))
    retorno))

(defun tabuleiro-preenche! (tabuleiro l c)
  (if (and (<= l 17) (<= c 9)) 
    (setf (aref tabuleiro (- 17 l) c) T))T)

(defun tabuleiro-despreenche (tabuleiro l c)
  (setf (aref tabuleiro (- 17 l) c) NIL))

(defun tabuleiro-remove-linha!(tabuleiro l)
  (dotimes(c 10)
    (tabuleiro-despreenche tabuleiro l c)))

(defun tabuleiro-topo-preenchido-p(tabuleiro)
  (dotimes(columns 10 NIL)
    (when (aref tabuleiro 0 columns)
      ;(setf p T)
      (return T))
    ))

(defun tabuleiros-iguais-p (tabuleiro1 tabuleiro2)
  (equalp tabuleiro1 tabuleiro2))

(defun tabuleiro->array(tabuleiro)
  (copia-tabuleiro tabuleiro))

(defun array->tabuleiro(array)      
  (let ((tabuleiro NIL))
    (setf tabuleiro (copia-tabuleiro array))
    tabuleiro))

(defun cria-estado(p ppc pc tab)
  (make-estado :pontos p :pecas-por-colocar ppc :pecas-colocadas pc :tabuleiro tab))

(defun copia-estado(eo)
  (make-estado :pontos (estado-pontos eo) 
               :pecas-por-colocar (copy-list (estado-pecas-por-colocar eo)) 
               :pecas-colocadas (copy-list (estado-pecas-colocadas eo)) 
               :tabuleiro (copia-tabuleiro (estado-tabuleiro eo))))

(defun estados-iguais-p(estado1 estado2)
  (and (eql(estado-pontos estado1)(estado-pontos estado2)) 
       (eql(estado-pecas-por-colocar estado1)(estado-pecas-por-colocar estado2))
       (eql(estado-pecas-colocadas estado1)(estado-pecas-colocadas estado2))
       (eql(estado-tabuleiro estado1) (estado-tabuleiro estado2))))

(defun estado-final-p(estado)
  (or (tabuleiro-topo-preenchido-p (estado-tabuleiro estado)) 
      (eql(estado-pecas-por-colocar estado) NIL)))

(defun solucao(estado)
  (and(not(tabuleiro-topo-preenchido-p (estado-tabuleiro estado))) 
    (eql(estado-pecas-por-colocar estado) NIL)))

(defun qualpeca(peca)
  (let ((lista nil))
        (when (equal peca 'i) (setf lista (list peca-i0 peca-i1) ))
        (when (equal peca 'l) (setf lista (list peca-l0 peca-l1 peca-l2 peca-l3) ))
        (when (equal peca 'j) (setf lista (list peca-j0 peca-j1 peca-j2 peca-j3) ))
        (when (equal peca 'o) (setf lista (list peca-o0) ))
        (when (equal peca 's) (setf lista (list peca-s0 peca-s1) ))
        (when (equal peca 'z) (setf lista (list peca-z0 peca-z1) ))
        (when (equal peca 't) (setf lista (list peca-t0 peca-t1 peca-t2 peca-t3) ))
       lista))

;(defun accoes(estado)
;     (let ((listapecas nil)(numerodepecasatestar 0)
;
;    (listapecas (qualpeca(car(estado-pecas-por-colocar estado))))
;
;    (numeropecasatestar (length listapecas))
;
;    (largurapeca (array-dimension(car(listapecas))))
;    (dotimes (i numerodepecasatestar)
;      (dotimes (j 10)
;        (dotimes (p largurapeca)
;          (and (when (aref (estado-tabuleiro estado) 0 (j+p) NIL))
;               (when (aref (car(listapecas) 0 p)))
;               (1+ pode))
;          (and (when (aref (estado-tabuleiro estado) 0 (j+p) NIL)
;               (when (aref (car(listapecas) 0 p NIL)
;              (1+ pode))
;                 ))))
;          (if eq(pode largurapeca)
;            (progn(;ADICIONARALISTAACCOES)(pop listapecas)
;            (pop listapecas))))
;       )))))


(defun qualidade(estado)
  (- (estado-pontos estado)))

(defun calculapontosporpeca(peca)
  (let ((retorno 0))
  (when(eq peca 'i) (setf retorno 800))
  (when(eq peca 'j) (setf retorno 500))
  (when(eq peca 'l) (setf retorno 500))
  (when(eq peca 's) (setf retorno 300))
  (when(eq peca 'z) (setf retorno 300))
  (when(eq peca 't) (setf retorno 300))
  (when(eq peca 'o) (setf retorno 300))
  retorno))

;(defun custo-oportunidade(estado)
;  (let ( (pontosmaximo 0)(listalocal nil) )
;  (setq listalocal (copy-list (estado-pecas-colocadas estado)))

;  (loop for x in listalocal
;        do ( (+ pontosmaximo  (calculapontosporpeca x ) )))
;  pontosmaximo))


(load "utils.fas")
