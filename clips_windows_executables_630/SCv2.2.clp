(defmodule MAIN
   (export ?ALL)
)

(deftemplate MAIN::ptable
	(slot state)
	(slot grade) ;new attr.
	(slot father) ;new attr.
	(multislot classSerial)
	
	
)

(deftemplate MAIN::count
	(slot no)
	(slot amount)
)

(deftemplate MAIN::course
	(slot name)
	(slot grade)
	(slot desire-period)
	(slot undesire-period)
	(slot teacher)
	
)

(deffacts MAIN::course-data
	(course (name A)
			(grade 1)
			(desire-period 1)
			(undesire-period 2)
			(teacher EROS))
	(course (name B)
			(grade 1)
			(desire-period 2)
			(undesire-period 3)
			(teacher LILY))
	(course (name C)
			(grade 2)
			(desire-period 3)
			(undesire-period 4)
			(teacher AFU))
	(course (name D)
			(grade 2)
			(desire-period 4)
			(undesire-period 1)
			(teacher EROS))
	(course (name E)
			(grade 2)
			(desire-period 4)
			(undesire-period 1)
			(teacher LILY))
	(course (name F)
			(grade 1)
			(desire-period 3)
			(undesire-period 1)
			(teacher ZODIAC))
	
)

(deffacts MAIN::default
	(rtable A B C D E F Empty )
	
	(max-grade 2) ;new attr.
	
	(time 4)
	
	(ptable (state 1)(grade 1)(classSerial # 1) )
	

	(current-state  1)
	(current-grade  1)
	
	
	
	(count (no 1)(amount 0))
)

(defrule MAIN::start
   =>
   (focus SCHEDULE))


;===================START OF SCHEDULE===================

(defmodule SCHEDULE
	(import MAIN ?ALL)
)
    
(defrule SCHEDULE::calculate-count
	(current-state ?x)
	?f1 <- (count (no ?x)(amount ?y))
	=>
	(retract ?f1)
	(assert (count (no (+ 1 ?x))(amount    (length$ (find-all-facts ((?f ptable)) (> ?f:state 0)  ) )    ) ) )
)

(defrule SCHEDULE::count-node-used
	(declare (salience 3))
	(ptable (father ?x)(classSerial $?A))
	(ptable (father ?x)(classSerial $?B))
	(ptable (father ?x)(classSerial $?C))
	(test (not (or (eq ?A ?B)(eq ?A ?C)(eq ?B ?C) ) ) )
	
	?f1 <-(ptable)
	(test (eq (fact-index ?f1) ?x) )
	
	=>
	(retract ?x)
)

(defrule SCHEDULE::empty-handle ;利用code Gen.設定empty個數不得超過 time-課程數
	(declare (salience 3))
	?f1 <- (ptable (classSerial $? ?x $? ?x $? ?x $?))
	(test (eq ?x Empty))
	=>
	(retract ?f1)
)

(defrule SCHEDULE::delete-teacher-repetition
	(declare (salience 3))
	?f1 <- (ptable (classSerial $? ?S ?x $? ?a $? ?b $? ?S ?y $?) ) 
	(test (and (eq ?S #)(eq ?y (+ ?x 1) ) ) ) 
	(course (name ?a)(teacher ?c) ) 
	(course (name ?b)(teacher ?c) )
	=>
	(retract ?f1)
)

(defrule SCHEDULE::arrange
	(current-state ?x)
	(current-grade ?y)
	?f1 <- (ptable (state ?x)(grade ?y)(classSerial $?oldSerial) )
	(test (> ?x -1) )
	(rtable $? ?z $?)
	(course (name ?z)(grade ?y))
	=>
	(assert (ptable (state ?x)(grade (+ ?y 1) )(father (fact-index ?f1))(classSerial ?oldSerial ?z) ) )
)



(defrule SCHEDULE::change-grade
	(declare (salience -2) )
	?f1 <- (current-grade ?x)
	(max-grade ?y)
	(test  (< ?x ?y) )
	=>
	(retract ?f1)
	(assert (current-grade (+ ?x 1) ) )
)

(defrule SCHEDULE::segment
	(declare (salience -3) )
	(current-state ?x)
	(current-grade ?i)
	?f1 <- (ptable (state ?x)(grade ?k)(father ?daddy)(classSerial $?oldSerial ?y) )
	(test (not (eq (+ ?x 1) ?y) ) )
	(test (eq ?k (+ ?i 1) ) )
	=>
	(retract ?f1)
	(assert (ptable (state (+ ?x 1) )(grade 1)(father ?daddy)(classSerial $?oldSerial ?y # (+ ?x 1) ) ) )
)

(defrule SCHEDULE::finished
	(declare (salience -4) )
	?f1 <- (current-state ?x)
	(time ?x)
	=>
	(retract ?f1)
	(assert (current-state -1) )
)

(defrule SCHEDULE::change-ball
	(declare (salience -6))
	?f1 <- (current-state ?x)
	?f2 <- (current-grade ?y)
	(test (> ?x -1) )
	=>
	(retract ?f1)
	(retract ?f2)
	(assert (current-state (+ ?x 1) ) )
	(assert (current-grade 1) )
)

;===================END OF SCHEDULE===================


;===================START OF SCORE===================


