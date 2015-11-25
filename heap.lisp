; https://domenicosolazzo.wordpress.com/2010/09/26/heapsort-a-python-example/
(defun parent(i)
    (floor i 2))

(defun left(i)
    (* 2 i))

(defun right(i)
    (+ (* 2 i) 1))

(defun heap-length (heap) (length heap))

(defun heapify (heap-list i n)
    (let (  (left       (left i))
            (right      (right i))
            (largest    -1)
            (aux        nil))

            (if (>= left (nth i heap-list)) 
                (setf largest left)
                (setf largest i))

            (if (>= right (nth i heap-list))
                (setf largest right))

            (if (not (eq largest i))
                ; swap
                (progn
                    (setf aux (nth i heap-list))
                    (setf (nth i heap-list) (nth largest heap-list))
                    (setf (nth largest heap-list) aux)
                    (heapify heap-list largest n)))))

(defun build-heap (heap-list)
   (let (  (len (heap-length heap-list) ) 
           (upvalue (/ (heap-length heap-list) 2)))
       (loop for i from upvalue downto 0 do
        (heapify heap-list i len))))



