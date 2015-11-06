; GRUPO 29 - Bruno Cardoso 72619; Francisco Calisto 70916; Lidia Freitas 78559


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
;                                        TIPO ACCAO                                       ;
; ======================================================================================= ;

    (defun cria-accao (coluna peca)
      "cria um par accao com a coluna mais a esqueda da peca, e a peca"
       (cons coluna peca))

    (defun accao-coluna (accao)
     (car accao))

    (defun accao-peca (accao)
     (cdr accao))

; ======================================================================================= ;
;                                        TIPO TABULEIRO                                   ;
; ======================================================================================= ;

    (defun cria-tabuleiro ()
     (make-array (list 18 10) :initial-element nil))

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
       (when (not (tabuleiro-preenchido-p tabuleiro l columns))
        (setf retorno NIL)
        (return)))
      retorno))

    (defun tabuleiro-preenche! (tabuleiro l c)
     (if (and (< l 18) (< c 10)) 
      (setf (aref tabuleiro (- 17 l) c) T))
     T)

    (defun tabuleiro-despreenche (tabuleiro l c)
     (setf (aref tabuleiro (- 17 l) c) NIL))

    (defun tabuleiro-remove-linha!(tabuleiro l)
     (if (= l 17)
      (dotimes(c 10)
       (tabuleiro-despreenche tabuleiro l c))
      (progn (dotimes (c 10)
              (setf (aref tabuleiro (- 17 l) c) (aref tabuleiro (1- (- 17 l)) c)))
       (tabuleiro-remove-linha! tabuleiro (1+ l)))))

    (defun tabuleiro-topo-preenchido-p(tabuleiro)
     (dotimes(columns 10 NIL)
      (when (aref tabuleiro 0 columns)
       (return T))))

    (defun tabuleiros-iguais-p (tabuleiro1 tabuleiro2)
     (equalp tabuleiro1 tabuleiro2))

    (defun tabuleiro->array(tabuleiro)
     (copia-tabuleiro tabuleiro))

    (defun array->tabuleiro(array)      
     (let ((tabuleiro NIL))
      (setf tabuleiro (copia-tabuleiro array))
      tabuleiro))

; ======================================================================================= ;
;                                        TIPO ESTADO                                      ;
; ======================================================================================= ;

    (defun cria-estado(p ppc pc tab)
     (make-estado :pontos p :pecas-por-colocar ppc :pecas-colocadas pc :tabuleiro tab))

    (defun copia-estado(eo)
     (make-estado :pontos (estado-pontos eo) 
      :pecas-por-colocar (copy-list (estado-pecas-por-colocar eo)) 
      :pecas-colocadas (copy-list (estado-pecas-colocadas eo)) 
      :tabuleiro (copia-tabuleiro (estado-tabuleiro eo))))

    (defun estados-iguais-p(estado1 estado2)
     (and (eql(estado-pontos estado1)(estado-pontos estado2)) 
      (equal(estado-pecas-por-colocar estado1)(estado-pecas-por-colocar estado2))
      (equal (estado-pecas-colocadas estado1)(estado-pecas-colocadas estado2))
      (tabuleiros-iguais-p (estado-tabuleiro estado1) (estado-tabuleiro estado2))))

    (defun estado-final-p(estado)
     (or (tabuleiro-topo-preenchido-p (estado-tabuleiro estado)) 
      (eql(estado-pecas-por-colocar estado) NIL)))

; ======================================================================================= ;
;                       FUNCOES PROBLEMA PROCURA                                          ;
; ======================================================================================= ;

; ==================================== SOLUCAO ========================================== ;
    (defun solucao(estado)
     (and(not(tabuleiro-topo-preenchido-p (estado-tabuleiro estado))) 
      (eql(estado-pecas-por-colocar estado) NIL)))

; ==================================== ACCOES =========================================== ;

    (defun qual-peca(peca)
     (let ((lista nil))
      (when (equal peca 'i) (setf lista (list peca-i0 peca-i1) ))
      (when (equal peca 'l) (setf lista (list peca-l0 peca-l1 peca-l2 peca-l3) ))
      (when (equal peca 'j) (setf lista (list peca-j0 peca-j1 peca-j2 peca-j3) ))
      (when (equal peca 'o) (setf lista (list peca-o0) ))
      (when (equal peca 's) (setf lista (list peca-s0 peca-s1) ))
      (when (equal peca 'z) (setf lista (list peca-z0 peca-z1) ))
      (when (equal peca 't) (setf lista (list peca-t0 peca-t1 peca-t2 peca-t3) ))
      lista))

    (defun accoes(estado)
     (let ((lista-pecas nil)(numero-pecas-a-testar 0)(largura-peca 0)(retorno (list)))
      (setf lista-pecas (qual-peca (car(estado-pecas-por-colocar estado)) ))
      (setf numero-pecas-a-testar (length lista-pecas))
      (dotimes (i numero-pecas-a-testar)
       (setf largura-peca (array-dimension(car lista-pecas) 1))
       (dotimes (j 10)
        (when (< (+ j largura-peca) 11)
         (push  (cria-accao j (car lista-pecas)) retorno)))
       (pop lista-pecas))
      (reverse retorno)))
    
; ==================================== RESULTADO ======================================== ; 

    (defun peca-altura-coluna(peca c)
     (let ((altura 0))
      (dotimes(l (array-dimension peca 0))
       (when (aref peca l c) 
        (setf altura l) 
        (return)))
      altura))

    (defun resultado(estado accao)
     (let ((novo-estado (copia-estado estado))(altura-peca nil)
           (altura-tabuleiro nil) (diff 0)
           (col (first accao))
           (pc (rest accao))
           (max-altura 0)
           (pontos-extra 0)
           (pontos-iniciais (estado-pontos novo-estado))
           (novo-tabuleiro (estado-tabuleiro novo-estado)))

      (dotimes (c (array-dimension pc 1))
       (setf altura-peca (peca-altura-coluna pc c))
       (setf altura-tabuleiro  (tabuleiro-altura-coluna novo-tabuleiro (+ c col)))
       (if (> (- altura-tabuleiro altura-peca) diff )
        (setf diff (- altura-tabuleiro altura-peca)))
       (setf max-altura diff))

    ; loop para preencher o tabuleiro com uma dada peca
    (loop for l from max-altura upto (min 17 (1- (+ max-altura (array-dimension pc 0)))) do
     (loop for c from col upto (1- (+ col (array-dimension pc 1))) do
      (if (aref pc (- l max-altura) (- c col))
       (setf (aref novo-tabuleiro (- 17 l) c) (aref pc (- l max-altura) (- c col))))))

    (when (tabuleiro-topo-preenchido-p novo-tabuleiro)
     (return-from resultado novo-estado))

    (let ((count 0))
     (dotimes (l (array-dimension pc 0))
      (when (tabuleiro-linha-completa-p novo-tabuleiro (+ max-altura l))
       (incf count)
       (tabuleiro-remove-linha! novo-tabuleiro (+ max-altura l))
       (decf max-altura)))

     (cond   ((= count 1) (setf pontos-extra 100))
      ((= count 2) (setf pontos-extra 300))
      ((= count 3) (setf pontos-extra 500))
      ((> count 3) (setf pontos-extra 800)))
     (setf pontos-iniciais (+ pontos-iniciais pontos-extra)))

    ; actualiza a lista das pecas-colocadas
    (push (first (estado-pecas-por-colocar novo-estado)) (estado-pecas-colocadas novo-estado))
    ;retira a peca colocada da lista das pecas por-colocar
    (pop (estado-pecas-por-colocar novo-estado))
    novo-estado))

; ==================================== QUALIDADE ======================================== ; 

    (defun qualidade(estado)
     (- (estado-pontos estado)))

; ============================== CUSTO-OPORTUNIDADE ===================================== ; 

    (defun calcula-pontos-por-peca(peca)
     (let ((retorno 0))
      (when(equal peca 'i) (setf retorno 800))
      (when(equal peca 'j) (setf retorno 500))
      (when(equal peca 'l) (setf retorno 500))
      (when(equal peca 's) (setf retorno 300))
      (when(equal peca 'z) (setf retorno 300))
      (when(equal peca 't) (setf retorno 300))
      (when(equal peca 'o) (setf retorno 300))
      retorno))

    (defun custo-oportunidade(estado)
     (let ( (pontos-maximo 0)(lista-local nil) )
      (setf lista-local (copy-list (estado-pecas-colocadas estado)))
      (dolist (x lista-local)
       (setf pontos-maximo (+ (calcula-pontos-por-peca x) pontos-maximo)))
      (- pontos-maximo (estado-pontos estado))))

    (load "utils.fas")

