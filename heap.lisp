; https://domenicosolazzo.wordpress.com/2010/09/26/heapsort-a-python-example/
(defun parent(i)
    (floor i 2))

(defun left(i)
    (* 2 i))

(defun right(i)
    (+ (* 2 i) 1))

(defun heap-length (heap) (length heap))

;; These could be made inline

(defun heap-val (heap i key) (declare (fixnum i)) (funcall key (aref heap i)))
(defun heap-parent (i) (declare (fixnum i)) (floor (- i 1) 2))
(defun heap-left (i) (declare (fixnum i)) (the fixnum (+ 1 i i)))
(defun heap-right (i) (declare (fixnum i)) (the fixnum (+ 2 i i)))

(defun heapify (heap i key)
  "Assume that the children of i are heaps, but that heap[i] may be 
  larger than its children.  If it is, move heap[i] down where it belongs.
  [Page 143 CL&R]."
  (let ((l (heap-left i))
    (r (heap-right i))
    (N (- (length heap) 1))
    smallest)
    (setf smallest (if (and (<= l N) (<= (heap-val heap l key)
                     (heap-val heap i key)))
               l i))
    (if (and (<= r N) (<= (heap-val heap r key) (heap-val heap smallest key)))
    (setf smallest r))
    (when (/= smallest i)
      (rotatef (aref heap i) (aref heap smallest))
      (heapify heap smallest key))))

(defun build-heap (heap-list)
   (let (  (len (heap-length heap-list) ) 
           (upvalue (/ (heap-length heap-list) 2)))
       (loop for i from upvalue downto 0 do
        (heapify heap-list i len))))



