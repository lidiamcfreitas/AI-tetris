; https://domenicosolazzo.wordpress.com/2010/09/26/heapsort-a-python-example/

    (defstruct heap
     (elements nil))

    (defstruct element
     (valor nil)
     (estado nil)
     (accoes nil))

    (defun heap-size (heap) 
     (length (heap-elements heap)))

; remove last element from list
    (defun remove-last(l)
     (reverse (cdr (reverse l))))

    (defun remove-last! (x)
     (do ((y x (cdr y)))
      ((null (cddr y))
       (and (rplacd y nil) (return x)))))

    (defun parent(i)
     (if (eq i 0) 
      nil 
      (floor i 2)))

    (defun left(i heap)
     (incf i)
     (if (<= (* 2 i) (heap-size heap)) 
      (- (* 2 i) 1) 
      nil))

    (defun right(i heap)
     (incf i)
     (if (< (+ (* 2 i) 1) (heap-size heap)) 
      (* 2 i)
      nil))

    (defun max-heapify (heap-struct i)
     (let (  (left       (left i heap-struct))
             (right      (right i heap-struct))
             (left-elem  nil)
             (right-elem nil)
             (i-elem     nil)
             (largest    -1)
             (heap       (heap-elements heap-struct)))

      (setf left-elem   (nth left heap))
      (setf right-elem  (nth right heap))
      (setf i-elem      (nth i heap))

      (if (and (not (eq left nil)) (>= (element-valor left-elem) (element-valor i-elem))) 
       (setf largest left)
       (setf largest i))

      (if (and (not (eq right nil)) (>= (element-valor right-elem) (element-valor (nth largest heap))))
       (setf largest right))

      (if (not (eq largest i))
       (progn
        ;(print largest)
        ;(print i)
        (rotatef (nth largest heap) (nth i heap))
        (max-heapify heap-struct largest)))))

    ; WORK IN PROGRESS

    (defun build-heap (heap)
     (let ((upvalue (- (floor (heap-size heap) 2) 1)))
      (loop for i from upvalue downto 0 do 
       ;(print i)
       (max-heapify heap i))
      heap))

    (defun heap-increase-key (heap i key)
     (if (< key (nth i heap)) 
      (return-from heap-increase-key 'keyValueError))
     (setf (nth i heap) key)
     (loop while (and (> i 0) (not (eq (parent i) nil)) (< (nth (parent i) heap) (nth i heap))) do
      (rotatef (nth i heap) (nth (parent i) heap))
      (setf i (parent i)))
     heap)

    ;(defun heap-sort (heap)
            ;    (let ((upvalue (1- (heap-size heap))))
                ;    (build-heap heap)
                ;    (loop for i from upvalue downto 1 do
                    ;        (rotatef (nth 0 heap) (nth i heap))
                    ;        (remove-last! heap)
                    ;        (max-heapify heap 0))))

    (defun heap-extract-max (heap)
     (let ((max (nth 0 heap)))
      (setf (nth 0 heap) (nth (1- (heap-size heap)) heap))
      (remove-last! heap)
      (max-heapify heap 0)
      max))

(defun max-heap-insert (heap key)
 (setf heap (append heap '(0)))
 (heap-increase-key heap (1- (heap-size heap)) key))
