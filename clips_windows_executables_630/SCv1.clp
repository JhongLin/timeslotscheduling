(defmodule MAIN
   (export ?ALL)
)

(deftemplate MAIN::ptable
	(slot num)
	(multislot classSerial)
)

(deffacts MAIN::default
	(rtable A B C Empty )
	
	(time 5) 
	
	(ptable (num 0) )
	
	(current-state  0) 
)

(defrule MAIN::start
   =>
   (focus SCHEDULE))

;===================START OF SCHEDULE===================

(defmodule SCHEDULE
	(import MAIN ?ALL)
)

(defrule SCHEDULE::delete-node
	(declare (salience -2) )
	(current-state ?z)
	?f2 <- (ptable (num ?z) )
	=>
	(retract ?f2)
)

(defrule SCHEDULE::change-ball
	(declare (salience -6))
	?f1 <- (current-state ?x)
	(test (> ?x -1) )
	=>
	(retract ?f1)
	(assert (current-state (+ ?x 1) ) )
)

(defrule SCHEDULE::finished
	(declare (salience -4))
	?f1 <- (current-state ?x)
	(time ?y)
	(test (eq ?y (+ ?x 1) ) )
	
	=>
	(retract ?f1)
	(assert (current-state -1) )
)


(defrule SCHEDULE::arrange
	(current-state ?x)
	?f1 <- (ptable (num ?x)(classSerial $?oldSerial) )
	(test (> ?x -1) ) 
	(rtable $? ?y $?)
	=>
	(assert (ptable (num (+ ?x 1) )(classSerial ?oldSerial ?y) ) )
)


(defrule SCHEDULE::delete-repetition
	(declare (salience 3) )
	?f1 <- (ptable (classSerial $? ?x $? ?x) )
	(not (test (eq ?x Empty) ) ) 
	=>
	(retract ?f1)
)

(defrule SCHEDULE::empty-handle ;設定empty個數不得超過 time-課程數
	?f1 <-  (ptable (classSerial $? ?x $? ?x $? ?x $?) )
	(test (eq ?x Empty) )
	=>
	(retract ?f1)	
)
;===================END OF SCHEDULE===================


;===================START OF SCORE===================