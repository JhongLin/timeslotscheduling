(defmodule MAIN
   (export ?ALL)
)

(deftemplate MAIN::ptable
	(slot num)
	(multislot classSerial)
)

(deffacts MAIN::default
	(rtable A B C Empty )
	
	(time 3) ;default 3 balls
	
	(ptable (num 0) )
	
	(current-state  0) 
)



(defmodule SCHEDULE
	(import MAIN ?ALL)
)

(deftemplate SCHEDULE::use-rtable
	(multislot queue)
)

(defrule SCHEDULE::construction
	(declare (salience 5))
	(rtable $?x) 
	=>
	(assert (use-rtable (queue ?x) ) )
)

(defrule SCHEDULE::renew-the-queue
	?f1 <- (use-rtable (queue $?x) )
	(test (eq (length$ ?x) 0) )
	(rtable  $?y) 
	(current-state ?z)
	?f2 <- (ptable (num ?z) )
	=>
	(retract ?f1)
	(retract ?f2)
	(assert (use-rtable (queue ?y) ) )

)

(defrule SCHEDULE::change-ball
	(declare (salience -3))
	?f1 <- (current-state ?x)
	(test (> ?x -1) )
	=>
	(retract ?f1)
	(assert (current-state (+ ?x 1) ) )
)

(defrule SCHEDULE::finished
	(declare (salience -2))
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
	?f2 <- (use-rtable (queue ?new $?remain) )
	=>
	(retract ?f2)
	(assert (use-rtable (queue ?remain)))
	(assert (ptable (num (+ ?x 1) )(classSerial ?oldSerial ?new) ) )
)


(defrule SCHEDULE::delete-duplication
	(declare (salience 3) )
	?f1 <- (ptable (classSerial $? ?y $? ?x) )
	(test (eq ?x ?y) )
	(not (test (eq ?x Empty) ) )
	=>
	(retract ?f1)
)
