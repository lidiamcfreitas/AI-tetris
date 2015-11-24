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
;                               PROJECTO | PRIMEIRA PARTE                                 ;
;                                                                                         ;
; ======================================================================================= ;
; ======================================================================================= ;


; ======================================================================================= ;
;                                        TIPO ACCAO                                       ;
; ======================================================================================= ;

    (defun cria-accao (coluna peca)
      "cria um par accao com a coluna mais a esqueda da peca, e a configuracao da peca"
      (cons coluna peca))

    (defun accao-coluna (accao)
      " devolve a coluna mais a esquerda a partir do qual a peca vai ser colocada"
      (car accao))

    (defun accao-peca (accao)
      "selector devolve o array com a configuracao geometrica exacta com que vai ser 
      colocada."
      (cdr accao))

; ======================================================================================= ;
;                                        TIPO TABULEIRO                                   ;
; ======================================================================================= ;

    (defun cria-tabuleiro ()
      "devolve um novo tabuleiro vazio."
      (make-array (list 18 10) :initial-element nil))

    (defun copia-tabuleiro(tabuleiro-arg)
      "recebe um tabuleiro, e devolve um novo tabuleiro com o mesmo conteudo do tabuleiro
       recebido"
     (let ((linhas 18)(tabuleiro-novo nil) (colunas 10))
      (setf tabuleiro-novo (make-array (list linhas colunas)))
      (dotimes (i linhas)
       (dotimes (j colunas)
        (setf (aref tabuleiro-novo i j) (aref tabuleiro-arg i j))))
      tabuleiro-novo))


    (defun tabuleiro-preenchido-p (tabuleiro l c)
      "retorna o valor logico T se a posicao (l,c) do tabuleiro estiver preenchida e NIL
       c.c." 
     (aref tabuleiro (- 17 l) c))

    (defun tabuleiro-altura-coluna(tabuleiro c)
      "devolve a altura de uma coluna, posicao mais alta que esteja preenchida dessa 
      coluna"
     (let ((altura 0))
      (dotimes(l 18)
       (when (aref tabuleiro l c) 
        (setf altura (- 18 l)) 
        (return)))
      altura))

    (defun tabuleiro-linha-completa-p(tabuleiro l)
      "devolve o valor logico T se todas as posicoes da linha recebida estiverem 
      preenchidas e NIL c.c."
     (let ((retorno T))  
      (dotimes (columns 10)
       (when (not (tabuleiro-preenchido-p tabuleiro l columns))
        (setf retorno NIL)
        (return)))
      retorno))

    (defun tabuleiro-preenche! (tabuleiro l c)
      "altera o tabuleiro para na posicao correspondente a linha e coluna passar a
       estar preenchido."
     (if (and (< l 18) (< c 10)) 
      (setf (aref tabuleiro (- 17 l) c) T))
     T)

    (defun tabuleiro-despreenche (tabuleiro l c)
      "altera o tabuleiro para na posicao correspondente a linha e coluna passar a nao
       estar preenchido."
     (setf (aref tabuleiro (- 17 l) c) NIL))

    (defun tabuleiro-remove-linha!(tabuleiro l)
      "altera o tabuleiro recebido removendo a linha l do tabuleiro"
     (if (= l 17)
      (dotimes(c 10)
       (tabuleiro-despreenche tabuleiro l c))
      (progn (dotimes (c 10)
              (setf (aref tabuleiro (- 17 l) c) (aref tabuleiro (1- (- 17 l)) c)))
       (tabuleiro-remove-linha! tabuleiro (1+ l)))))

    (defun tabuleiro-topo-preenchido-p(tabuleiro)
      "devolve o valor logico T se existir alguma pos. na linha do topo do tabuleiro que 
      esteja preenchida e NIL c.c."
     (dotimes(columns 10 NIL)
      (when (aref tabuleiro 0 columns)
       (return T))))

    (defun tabuleiros-iguais-p (tabuleiro1 tabuleiro2)
      "devolve o valor logico T se os dois tabuleiros forem iguais e NIL c.c."
     (equalp tabuleiro1 tabuleiro2))

    (defun tabuleiro->array(tabuleiro-arg)
     (let ((linhas 18)(tabuleiro-novo nil) (colunas 10))
      (setf tabuleiro-novo (make-array (list linhas colunas)))
      (dotimes (i linhas)
       (dotimes (j colunas)
        (setf (aref tabuleiro-novo (- 17 i) j) (aref tabuleiro-arg i j))))
      tabuleiro-novo))

    (defun array->tabuleiro(array)
     "converte um tabuleiro em formato array para o formato da implementacao do codigo"     
     (let ((tabuleiro NIL))
      (setf tabuleiro (copia-tabuleiro array))
      tabuleiro))

; ======================================================================================= ;
;                                        TIPO ESTADO                                      ;
; ======================================================================================= ;

    (defun cria-estado(p ppc pc tab)
     "retorna uma estrutura do tipo estado com os argumentos: pontos, pecas por colocar, 
     pecas colocadas e tabuleiro"
     (make-estado :pontos p :pecas-por-colocar ppc :pecas-colocadas pc :tabuleiro tab))

    (defun copia-estado(eo)
      "recebe um estado e devolve um novo estado cujo conteudo e copiado a partir do 
      estado original"
     (make-estado :pontos (estado-pontos eo) 
      :pecas-por-colocar (copy-list (estado-pecas-por-colocar eo)) 
      :pecas-colocadas (copy-list (estado-pecas-colocadas eo)) 
      :tabuleiro (copia-tabuleiro (estado-tabuleiro eo))))

    (defun estados-iguais-p(estado1 estado2)
     "recebe dois estados, e devolve o valor logico verdade se os dois estados forem 
     iguais"
     (and (eql(estado-pontos estado1)(estado-pontos estado2)) 
      (equal(estado-pecas-por-colocar estado1)(estado-pecas-por-colocar estado2))
      (equal (estado-pecas-colocadas estado1)(estado-pecas-colocadas estado2))
      (tabuleiros-iguais-p (estado-tabuleiro estado1) (estado-tabuleiro estado2))))

    (defun estado-final-p(estado)
     "recebe um estado e devolve o valor logico T se corresponder a um estado final e 
     NIL c.c."
     (or (tabuleiro-topo-preenchido-p (estado-tabuleiro estado)) 
      (eql(estado-pecas-por-colocar estado) NIL)))

; ======================================================================================= ;
;                                FUNCOES PROBLEMA PROCURA                                 ;
; ======================================================================================= ;

; ==================================== SOLUCAO ========================================== ;
    (defun solucao(estado)
     "recebe um estado e devolve T se o estado for uma solucao para o problema de procura,
      e NIL c.c."
     (and(not(tabuleiro-topo-preenchido-p (estado-tabuleiro estado))) 
      (eql(estado-pecas-por-colocar estado) NIL)))

; ==================================== ACCOES =========================================== ;

    (defun qual-peca(peca)
     "recebe uma peca e retorna uma lista com todas as posicoes em que a peca pode estar"
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
     "recebe um estado e retorna uma lista de todas as accoes validas que podem ser 
     feitas com a proxima peca a ser colocada"
     (let ((lista-pecas nil)(numero-pecas-a-testar 0)(largura-peca 0)(retorno (list)))



      (setf lista-pecas (qual-peca (car(estado-pecas-por-colocar estado)) ))
      (setf numero-pecas-a-testar (length lista-pecas))
      (dotimes (i numero-pecas-a-testar)
       (setf largura-peca (array-dimension(car lista-pecas) 1))
       (dotimes (j 10)
        (when (< (+ j largura-peca) 11)
         (push  (cria-accao j (car lista-pecas)) retorno)))
       (pop lista-pecas))
      (when (estado-final-p estado) (setf retorno nil))
      (reverse retorno)))
    
; ==================================== RESULTADO ======================================== ; 

    (defun peca-altura-coluna(peca c)
     "retorna a altura da posicao T mais baixa da peca na coluna c da sua representacao"
     (let ((altura 0))
      (dotimes(l (array-dimension peca 0))
       (when (aref peca l c) 
        (setf altura l) 
        (return)))
      altura))

    (defun resultado(estado accao)
     "devolve um estado novo que consiste em aplicar a accao recebida ao estado original"
     (let ((novo-estado (copia-estado estado))
           (altura-peca nil)
           (altura-tabuleiro nil) 
           (col (accao-coluna accao))
           (pc (accao-peca accao))
           (max-altura 0)
           (pontos-extra 0)
           (counter 0))
    
      ; descobre em que posicao deve colocar a peca
      (dotimes (c (array-dimension pc 1))
       (setf altura-peca (peca-altura-coluna pc c))
       (setf altura-tabuleiro  (tabuleiro-altura-coluna (estado-tabuleiro novo-estado) (+ c col)))
       (if (> (- altura-tabuleiro altura-peca) max-altura )
        (setf max-altura (- altura-tabuleiro altura-peca))))

    ; loop para preencher o tabuleiro com uma dada peca
    (loop for l from max-altura upto (min 17 (1- (+ max-altura (array-dimension pc 0)))) do
     (loop for c from col upto (1- (+ col (array-dimension pc 1))) do
      (if (aref pc (- l max-altura) (- c col))
       (setf (aref (estado-tabuleiro novo-estado) (- 17 l) c) (aref pc (- l max-altura) (- c col))))))
    
    ; retorna o estado se o topo estiver preenchido
    (when (tabuleiro-topo-preenchido-p (estado-tabuleiro novo-estado))
     (return-from resultado novo-estado))

    ; conta o numero de linhas completas e apaga-as
     (dotimes (l (array-dimension pc 0))
      (when (tabuleiro-linha-completa-p (estado-tabuleiro novo-estado) (+ max-altura l))
       (incf counter)
       (tabuleiro-remove-linha! (estado-tabuleiro novo-estado) (+ max-altura l))
       (decf max-altura)))
    
    ; atribui os pontos pelas novas linhas
     (cond   ((= counter 1) (setf pontos-extra 100))
      ((= counter 2) (setf pontos-extra 300))
      ((= counter 3) (setf pontos-extra 500))
      ((> counter 3) (setf pontos-extra 800)))
     (setf (estado-pontos novo-estado) (+ (estado-pontos novo-estado) pontos-extra))

    ; actualiza a lista das pecas-colocadas
    (push (first (estado-pecas-por-colocar novo-estado)) (estado-pecas-colocadas novo-estado))
    ;retira a peca colocada da lista das pecas por-colocar
    (pop (estado-pecas-por-colocar novo-estado))

    novo-estado))

; ==================================== QUALIDADE ======================================== ; 

    (defun qualidade(estado)
     "recebe um estado e retorna um valor de qualidade que corresponde ao valor negativo 
     dos pontos ganhos ate ao momento"
     (- (estado-pontos estado)))

; ============================== CUSTO-OPORTUNIDADE ===================================== ; 

    (defun calcula-pontos-por-peca(peca)
     "retorna o valor maximo de pontos que uma peca pode gerar"
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
     "retorna a diferenca entre o maximo possivel de pontos e o efectivamente conseguido"
     (let ( (pontos-maximo 0)(lista-local nil) )
      (setf lista-local (copy-list (estado-pecas-colocadas estado)))
      (dolist (x lista-local)
       (setf pontos-maximo (+ (calcula-pontos-por-peca x) pontos-maximo)))
      (- pontos-maximo (estado-pontos estado))))

(defun procura-pp (problema)
   (let ((pred NIL)(accoes (problema-accoes problema))
   		(solucao (problema-solucao problema))
       (resultado (problema-resultado problema))
       (estado-inicial (problema-estado-inicial problema)) )
     ; labels e equivalente a flet excepto que o ambito dos nomes das funcoes definidas
     ; para etiquetas engloba a funcao com definicoes de si mesma, bem como o corpo.
     (labels ((dfsaux (estado)
       (let ((aux NIL))
          (when (solucao estado)
           (setf pred T))
         (if (estado-final-p estado)
           (return-from dfsaux NIL))
           (dolist (accao (accoes estado-inicial))
             (setf aux (dfsaux (resultado estado accao)))
             (if pred
               (return-from dfsaux (cons accao aux))))
               NIL)))
       (dfsaux estado-inicial))))

    (load "utils.lisp")
