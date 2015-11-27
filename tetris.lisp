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

    (defstruct elemento
    (valor NIL)
    (estado NIL)
    (accoes NIL))

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
     (let ((novo-estado     (copia-estado estado))
           (altura-peca     nil)
           (altura-tabuleiro nil) 
           (col             (accao-coluna accao))
           (pc              (accao-peca accao))
           (max-altura      0)
           (pontos-extra    0)
           (counter         0)
           (peca-pos        nil))
    
      ; descobre em que posicao deve colocar a peca
      (dotimes (c (array-dimension pc 1))
       (setf altura-peca (peca-altura-coluna pc c))
       (setf altura-tabuleiro  (tabuleiro-altura-coluna (estado-tabuleiro novo-estado) (+ c col)))
       (if (> (- altura-tabuleiro altura-peca) max-altura )
        (setf max-altura (- altura-tabuleiro altura-peca))))

    ; loop para preencher o tabuleiro com uma dada peca
    (loop for l from max-altura upto (min 17 (1- (+ max-altura (array-dimension pc 0)))) do
     (loop for c from col upto (1- (+ col (array-dimension pc 1))) do
      (setf peca-pos (aref pc (- l max-altura) (- c col)))
      (if peca-pos
       (tabuleiro-preenche! (estado-tabuleiro novo-estado) l c))))
    
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
    (let (  (estado-inicial (problema-estado-inicial problema))
            (f-solucao          (problema-solucao problema))
            (f-accoes           (problema-accoes problema))
            (f-resultado        (problema-resultado problema))
            (resultado          nil)
            (dfs-resultado      nil)
            (res                nil))
        (labels 
            ((dfs (estado)
                (cond ((funcall f-solucao estado) (return-from dfs '())) 
                    (t (dolist (accao (reverse (funcall f-accoes estado)))
                        (setf resultado (funcall f-resultado estado accao))
                        (setf dfs-resultado (dfs resultado))
                        (if (not (eq 'impossivel dfs-resultado))
                            (return-from dfs (append (list accao) dfs-resultado))))))
                'impossivel))
        (setf res (dfs estado-inicial))
        (if (eq 'impossivel res) nil res))))


(defun add-to (lista elem)
  (setf lista 
        (sort (append lista (list elem)) #'(lambda (x y) (<= (elemento-valor x) (elemento-valor y))))))

(defun pop-elem (lista)
  (cdr lista))

(defun peek-elem (lista)
  (car lista))

(defun procura-A* (problema f-heuristica)
    (let (  (estado-inicial (problema-estado-inicial problema))
            (f-solucao          (problema-solucao problema))
            (f-accoes           (problema-accoes problema))
            (f-resultado        (problema-resultado problema))
            (f-custo-caminho    (problema-custo-caminho problema))
            (elemento-ini       nil)
            (lista-prioridade   nil)
            (lista-accoes       nil)
            (novo-custo         nil)
            (novo-succ          nil)
            (novo-caminho       nil)
            (top-elem           nil))

      (setf elemento-ini (make-elemento :valor (funcall f-heuristica estado-inicial) :estado estado-inicial :accoes nil))
      
      (setf lista-prioridade (add-to lista-prioridade elemento-ini))
      ;(print lista-prioridade)
      (loop while lista-prioridade do
            (setf top-elem (peek-elem lista-prioridade))
            (setf lista-prioridade (pop-elem lista-prioridade))
            ; (print lista-prioridade)
            (if (funcall f-solucao (elemento-estado top-elem)) (return-from procura-A*  (elemento-accoes top-elem))) ; (progn (print (estado-pontos (elemento-estado top-elem))) (return-from procura-A*  (elemento-accoes top-elem))))
            ; (print "not solution")
            (setf lista-accoes (funcall f-accoes (elemento-estado top-elem)))
            (dolist (accao lista-accoes)
              (setf novo-succ  (funcall f-resultado (elemento-estado top-elem) accao))
              (setf novo-custo (+ (funcall f-custo-caminho novo-succ) (funcall f-heuristica novo-succ)))
              (setf novo-caminho (append (elemento-accoes top-elem) (list accao)))
              (setf lista-prioridade (add-to lista-prioridade (make-elemento :valor novo-custo :estado novo-succ :accoes novo-caminho)))))
              ;(print lista-prioridade)))
      nil))

(defun heur-altura-geral (estado)
  (let ((resultado 0) (tabuleiro (estado-tabuleiro estado)))
    (dotimes (coluna 10) 
      (setf resultado (+ resultado (tabuleiro-altura-coluna tabuleiro coluna))))
    resultado))

(defun inverte-tabuleiro (tabuleiro)
  (let ((novo-tabuleiro (cria-tabuleiro)))
    (dotimes (linha 18)
      (dotimes (coluna 10)
        (setf (aref novo-tabuleiro (- 17 linha) coluna) (aref tabuleiro linha coluna))))
    novo-tabuleiro))

(defun heur-relevo (estado)
  (let ((resultado 0) (tab (estado-tabuleiro estado)))
    (dotimes (col 9)
      (setf resultado (+ (abs (- (tabuleiro-altura-coluna tab col) (tabuleiro-altura-coluna tab (1+ col)))) resultado)))
    resultado))

(defun heuristica-geral (estado)
  ; (print (+ (heur-altura-geral estado) (/ (custo-oportunidade estado) 100)))
  (+ (heur-altura-geral estado) (/ (custo-oportunidade estado) 35) (heur-relevo estado)))


; Da mais peso as colunas que tem um maior num de posicoes livres e menor peso se o correspondente
; estiver na ultima linha do tabuleiro.
; Portanto, no fim de cada linha, ha o contador que conta o numero de conflitos encontrados e multiplica pelo
; numero-linhas-vazias. O resultado final e o produto da soma ponderada dos conflitos para cada
; linhas e numero de linhas livres, o que representa uma medida global do tabuleiro. Um tabuleiro com menos
; linhas livres e melhor do que outro tabuleiro com mais linhas livres.

; (defun heuristica-melhor-peso (estado)
;   (let* ((heuristica 0)
;          (posicoes (estado-tabuleiro estado))
;          (tamanho (length posicoes))
;          (numero-linhas-vazias 0)
;          (tabuleiro (estado-tabuleiro estado)))
;     (dolist (l tamanho)
;     	(let ((numero-conflitos 0))
; 	      	(when (null l)
; 	        	  (incf numero-linhas-vazias)
; 	          	(dolist (c tamanho)
; 	            	(when (not (tabuleiro-preenchido-p tabuleiro l c))
; 	                	  (incf numero-conflitos))))
;       		(setf heuristica (+ heuristica (* numero-linhas-vazias numero-conflitos)))))
;     (* heuristica numero-linhas-vazias)))

(defun procura-best (tab pecas-p-col)
  (let ((estado-ini nil)(elemento-ini nil)(problema nil))
  (setf tab (inverte-tabuleiro tab))
  (setf estado-ini (make-estado :pontos 0 :pecas-por-colocar pecas-p-col :pecas-colocadas () :tabuleiro tab))
  (setf elemento-ini (make-elemento :valor 0 :estado estado-ini :accoes nil)) ; TODO heuristica para valor

  (setf problema (make-problema :estado-inicial estado-ini :solucao #'solucao :accoes #'accoes :resultado #'resultado :custo-caminho #'(lambda (e) (/ (qualidade e) 100))))

  (procura-A* problema #'heuristica-geral))) 

(load "utils.lisp")


