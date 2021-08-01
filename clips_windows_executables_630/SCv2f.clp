(defmodule MAIN
   (export ?ALL)
)

(deftemplate MAIN::ptable
	(slot num)
	(multislot classSerial)
	(slot ar-count) ;new attr.
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
)

(deffacts MAIN::default
	(rtable A B C D Empty )
	
	(max-grade 2) ;new attr.
	
	(time 2)
	
	(ptable (num 1)(classSerial 0)(ar-count 0) )
	
	(current-state  1)
	(current-grade  1)
	
	(count (no 1)(amount 0))
)

(defrule MAIN::start
   =>
   (focus SCHEDULE)
)

;===================START OF SCHEDULE===================

(defmodule SCHEDULE
	(import MAIN ?ALL)
)
    
(defrule SCHEDULE::calculate-count
	(current-state ?x)
	?f1 <- (count (no ?x)(amount ?y))
	=>
	(retract ?f1)
	(assert (count (no (+ 1 ?x))(amount    (length$ (find-all-facts ((?f ptable)) (> ?f:num 0)  ) )    ) ) )
)

(defrule SCHEDULE::delete-node
	(declare (salience 3) )
	?f1 <- (ptable (ar-count 2) ) ;while the arrange count up to lessons' amount, delete the node 
	=>
	(retract ?f1)
)

(defrule SCHEDULE::delete-repetition
	(declare (salience 3) )
	?f1 <- (ptable (classSerial $? ?x $? ?x ) )
	(not (test (eq ?x Empty) ) )
	=>
	(retract ?f1)
)

(defrule SCHEDULE::empty-handle ;利用code Gen.設定empty個數不得超過 time-課程數
	(declare (salience 3))
	?f1 <- (ptable (classSerial $? ?x $? ?x $? ?x $?))
	(test (eq ?x Empty))
	=>
	(retract ?f1)	
)

;(defrule SCHEDULE::delete-teacher-repetition
;	(declare (salience 3))
;	(current-state ?x)
;	?f1 <- (ptable (classSerial $? ?y $? ?a $? ?b $? ?x) )  ;中間的變數個數為max-grade
;	(test (eq ?x (+ ?y 1) ) ) ;fuck! it cannot be used like that!
;	(course (name ?a)(teacher ?c) ) ;因為課程名稱不是數值 它在驗證rule時加int即跑出ERROR
;	(course (name ?b)(teacher ?c) )
;	=>
;	(retract ?f1)
;)

(defrule SCHEDULE::arrange
	(current-state ?x)
	?f1 <- (ptable (num ?x)(classSerial $?oldSerial ?front)(ar-count ?n) )
	(test (> ?x -1) )
	(rtable $? ?y $?)
	(course (name ?front)(grade ?i) )
	(course (name ?y)(grade ?z))
	(current-grade ?z)
	(test (not (eq ?i ?z) ) )
	=>
	(retract ?f1)
	(assert (ptable (num ?x)(classSerial ?oldSerial ?front)(ar-count (+ ?n 1) ) ) )
	(assert (ptable (num ?x)(classSerial ?oldSerial ?front ?y)(ar-count 0) ) )
)

(defrule SCHEDULE::arrange-backup  ;這個只是應急用法，由於上面的方法不完全
	(current-state ?x)
	?f1 <- (ptable (num ?x)(classSerial $?oldSerial ?front)(ar-count ?n) )
	(test (> ?x -1) )
	(rtable $? ?y $?)
	(test (eq ?front (- ?x 1) ) )
	(course (name ?y)(grade ?z))
	(current-grade ?z)
	=>
	(retract ?f1)
	(assert (ptable (num ?x)(classSerial ?oldSerial ?front)(ar-count (+ ?n 1) ) ) )
	(assert (ptable (num ?x)(classSerial ?oldSerial ?front ?y)(ar-count 0) ) )
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
	?f1 <- (ptable (num ?x)(classSerial $?oldSerial ?y)(ar-count ?j) )
	(test (not (eq ?x ?y) ) )
	=>
	(retract ?f1)
	(assert (ptable (num (+ ?x 1) )(classSerial $?oldSerial ?y ?x)(ar-count ?j) ) )
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


