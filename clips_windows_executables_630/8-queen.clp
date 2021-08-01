(defrule startup 
   =>
   (printout t "How many rows? ")
   (bind ?response (read))
   (assert (problem-size ?response)
           (possible-row ?response)
           (begin)
           (solution)))

(defrule generate-rows
   (possible-row ?row&~1)
   =>
   (assert (possible-row (- ?row 1))))

(defrule grow-solution
  (problem-size ?n)
  (possible-row ?r)
  (solution $?x)
  (test (< (length ?x) ?n))
  (test (not (member ?r ?x)))
  => 
  (assert (solution ?x ?r)))

(defrule prune-diagonal-attacks
  (declare (salience 20))
  ?fact <- (solution $?x ?v $?y ?c)
  (test (= (- (+ (length ?x) (length ?y) 2) (+ (length ?x) 1)) 
           (abs (- ?c ?v))))
  => 
  (retract ?fact))

(defrule print-solution
  (problem-size ?n)
  (solution $?x)
  (test (= (length ?x) ?n))
  =>
  (format t  "%n Solution:%n")
  (bind ?row 1)
  (while (<= ?row ?n) do
     (bind ?qrc (nth$ ?row ?x))
     (bind ?column 1)
     (while (<= ?column ?n) do
          (if (= ?qrc ?column) then (format t " Q")
                               else (format t " -"))
          (bind ?column (+ ?column 1)))
     (format t  "%n")
     (bind ?row (+ ?row 1))))

