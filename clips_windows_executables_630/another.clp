;Scenario: 3個時段、2個課程、同一年級

(deftemplate time			;時段(球)
	(slot sequence))
(deftemplate current-father
	(slot name))

	
(deftemplate lut
	(slot grade)
	(multislot class)
	(slot classroom)
	(slot teacher))
	
(deftemplate father-queue
	(multislot person))

(deftemplate course
	(slot name)
	(slot time_seq)
	(slot classroom)
	(multislot teacher)
	(multislot father) 	; 紀錄上一個位置
)
	
(deffacts course_data
	(course (name A_course)
			(time_seq 0)
			(father none))
	(course (name B_course)
			(time_seq 0)
			(father none))
	(course (name Empty)
			(time_seq 0)
			(father none))
)

(deffacts basic
	(lut (class terminal
				A_course
				B_course
				Empty_course
				))
	
	(change 1000)
	(father-queue (person X X ))
	(pre-father start)
	(change-father 1)
	(time (sequence 4))
	(current-father (name none))
	
	
	
)

;(defrule get_data
;	(declare (salience 50))
;	=>
;	(printout t "Please enter the sequence: ")
;	(bind ?response (read))
;	(assert (time (sequence ?response)))	
;)

(defrule schedule
	?f1 <- (lut (class $? ?class $?))
	?f2 <- (time (sequence ?time))
	?f3 <- (current-father (name ?father))
	?f4 <- (change ?change)
	?f5 <- (change-father ?change-father)
	(test (not (eq ?change-father 1)))
	=>
	(if (eq ?class terminal)
		then (printout t ?class crlf)(assert (change-father 1))
		else (assert (pre-father ?class))
		(assert (course (name ?class)(time_seq ?time)(father ?father))))

	
)

(defrule add-father-to-queue
	(declare (salience 50))
	?f1 <- (pre-father ?pre-father)
	?f2 <- (change-level 1)
	?f3 <- (father-queue (person $?person))
	=>
	(retract ?f1 ?f3)
	(assert (father-queue (person $?person ?pre-father)))
)

(defrule change-current-father
	?f1 <- (change-father 1)
	?f2 <- (current-father (name ?))
	?f3 <- (father-queue(person ?p1 ?p2 ?p3 $?p4))
	?f4 <- (change ?change)
	?f5 <- (change-level ?change-level)
	
	=>
	(retract ?f1 ?f2 ?f3 ?f4 )
	(assert (change-father 0))
	(assert (father-queue(person ?p1 ?p2 ?p4)))
	(assert (current-father (name ?p3)))
	(assert (change (- ?change 1)))
)

(defrule change-level
	?f1 <- (father-queue (person $?person))
	?f2 <- (time (sequence ?time))
	=>
	(if (eq (length$ ?person ) 2)
		then (modify ?f2 (sequence (- ?time 1)))
			 (assert (change-level 1)))
)



