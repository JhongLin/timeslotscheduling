(defmodule MAIN
   (export ?ALL)
)

(deftemplate MAIN::ball
	(slot resultNumber)
	(slot periodNumber)
	(slot grade)
	(slot classID)
	(slot isLast(default no)) ;yes or no
)

(deftemplate MAIN::signal
	(slot status)
)

(deftemplate MAIN::box-full
	(slot resultNumber)
	(slot classID)
)

(deftemplate MAIN::result
	(slot resultNumber)
	(slot SCORE)
	(slot status) ;(SCORE yet or done)
	(slot block)
)

(deftemplate MAIN::result-ToBeDeleted
	(slot num))
(deftemplate MAIN::unavailable-ball
	(slot grade)
	(multislot num))
(deftemplate MAIN::courses-count
	(slot resultNumber)
	(slot classID)
	(slot amount))

(deffacts MAIN::default
	(result (resultNumber 0)(SCORE 0)(status done2)(block B1))
	(ball (resultNumber 0)(periodNumber 0)(grade 2)(isLast yes) ) ;default max grade
	(result (resultNumber 1)(SCORE 0)(status done2)(block B2))
	(ball (resultNumber 1)(periodNumber 0)(grade 4)(isLast yes) )
	
	(unavailable-ball (grade 1)(num 4 5))
	(unavailable-ball (grade 2)(num 4 6))
	(unavailable-ball (grade 3)(num 2 4))
	(unavailable-ball (grade 4)(num 4))
	(exclusive-LOCK off)
	(result-picked -1)
	
	(now-turn B1)
	(min-grade 1) ;在排列,finished的rule中會用到
	(max-grade 2) ;在排列,finished的rule中會用到
	(max-period 10) ;finished的rule中會用到
)

(deftemplate MAIN::course
	(slot name)
	(slot classID) ;classID為一獨特編號,為避免有名稱相同但實際上不同門課的狀況
	(slot grade)
	(slot type)
	(slot period-needed)
	(multislot desire-period)
	(multislot undesire-period)
	(multislot teacher)
)
(deffacts MAIN::course-data
	(course (name A)
			(classID J01)
			(grade 1)
			(type compulsory)
			(period-needed 2)
			(desire-period 1 2)
			(undesire-period 3)
			(teacher EROS))
	(course (name B)
			(classID J02)
			(grade 1)
			(type elective)
			(period-needed 2)
			(desire-period 5 6)
			(undesire-period 3)
			(teacher LILY))
	(course (name C)
			(classID J03)
			(grade 1)
			(type elective)
			(period-needed 1)
			(desire-period 10)
			(undesire-period 1)
			(teacher ZODIAC))
	(course (name D)
			(classID J04)
			(grade 1)
			(type elective)
			(period-needed 3)
			(desire-period 7 8 9)
			(undesire-period 1)
			(teacher YUGA))
	(course (name E)
			(classID J05)
			(grade 2)
			(type elective)
			(period-needed 2)
			(desire-period 2 3)
			(undesire-period 4)
			(teacher AFU))
	(course (name F)
			(classID J06)
			(grade 2)
			(type compulsory)
			(period-needed 2)
			(desire-period 7 8)
			(undesire-period 1)
			(teacher EROS))
	(course (name G)
			(classID J07)
			(grade 2)
			(type elective)
			(period-needed 1)
			(desire-period 1)
			(undesire-period 3)
			(teacher LILY))
	(course (name H)
			(classID J08)
			(grade 2)
			(type elective)
			(period-needed 3)
			(desire-period 4 5 6)
			(undesire-period 1)
			(teacher ZODIAC))

			
	(course (name I)
			(classID J09)
			(grade 3)
			(type elective)
			(period-needed 2)
			(desire-period 7 3)
			(undesire-period 2)
			(teacher CATHERINE))
	(course (name J)
			(classID J10)
			(grade 3)
			(type compulsory)
			(period-needed 2)
			(desire-period 9 10)
			(undesire-period 9)
			(teacher EROS))
	(course (name K)
			(classID J11)
			(grade 3)
			(type elective)
			(period-needed 1)
			(desire-period 5 7)
			(undesire-period 9 10 7)
			(teacher JHONG))
	(course (name L)
			(classID J12)
			(grade 3)
			(type elective)
			(period-needed 3)
			(desire-period 7 8 9)
			(undesire-period 1)
			(teacher ZODIAC))
			
	(course (name M)
			(classID J13)
			(grade 4)
			(type elective)
			(period-needed 2)
			(desire-period 2 5)
			(undesire-period 2)
			(teacher CATHERINE))
	(course (name N)
			(classID J14)
			(grade 4)
			(type compulsory)
			(period-needed 2)
			(desire-period 5 6)
			(undesire-period 9 2)
			(teacher EROS))
	(course (name O)
			(classID J15)
			(grade 4)
			(type elective)
			(period-needed 1)
			(desire-period 2)
			(undesire-period 3)
			(teacher ZODIAC))
	(course (name P)
			(classID J16)
			(grade 4)
			(type elective)
			(period-needed 3)
			(desire-period 4 5 6)
			(undesire-period 1)
			(teacher YUGA))
			
			
			
			
			
			
	(course (name Empty)
			(classID K00)
			(grade 1)
			(type elective) 
			(period-needed 2)
			(teacher no)) 
	(course (name Empty)
			(classID K01)
			(grade 2)
			(type elective)
			(period-needed 2)
			(teacher no))
	(course (name Empty)
			(classID K02)
			(grade 3)
			(type elective)
			(period-needed 2)
			(teacher no))
	(course (name Empty)
			(classID K03)
			(grade 4)
			(type elective)
			(period-needed 2)
			(teacher no))
	
)

(defrule MAIN::Pick-highest-SCORE-result
	?f1 <- (exclusive-LOCK off)
	?f2 <- (result (resultNumber ?x)(SCORE ?y)(status done2)(block ?w))
	(not (result (SCORE ?more&:(> ?more ?y))(status done2)(block ?w)))
	?f3 <- (result-picked ?z) ;?z now isn't used
	(now-turn ?w)
	=>
	(retract ?f1)
	(assert (exclusive-LOCK on) )
	(retract ?f3)
	(assert (result-picked ?x) )
	(focus ARRANGE)
)

(defrule MAIN::singal-handle-forNextTurn
	(declare (salience 7))
	?f1 <- (signal (status on))
	=>
	(assert (min-grade 3))
	(assert (max-grade 4))
	(assert (now-turn B2))
	(retract ?f1)
)

(defrule MAIN::SCORE-for-desirePeriod
	(declare (salience 3))
	?f1 <- (result (resultNumber ?a)(SCORE ?point)(status yet)(block ?w))
	(ball (resultNumber ?a)(periodNumber ?b)(grade ?c)(classID ?d)(isLast yes) )
	(course (classID ?d)(desire-period $? ?b $?))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?a)(SCORE (+ ?point 1))(status done)(block ?w)) )
)

(defrule MAIN::SCORE-for-UndesirePeriod
	(declare (salience 3))
	?f1 <- (result (resultNumber ?a)(SCORE ?point)(status yet)(block ?w))
	(ball (resultNumber ?a)(periodNumber ?b)(grade ?c)(classID ?d)(isLast yes) )
	(course (classID ?d)(undesire-period $? ?b $?))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?a)(SCORE (- ?point 2))(status done)(block ?w)) )
)

(defrule MAIN::double-compulsory
	(declare (salience 3))
	(ball (resultNumber ?x)(periodNumber ?p)(classID ?y))
	(ball (resultNumber ?x)(periodNumber ?p)(classID ?z))
	(test (not (eq ?y ?z)))
	(course (classID ?y)(type compulsory))
	(course (classID ?z)(type compulsory))
	?f1 <- (result (resultNumber ?x)(SCORE ?point)(status done)(block ?w))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?x)(SCORE (- ?point 3))(status done2)(block ?w)) )
)
(defrule MAIN::triple-compulsory
	(declare (salience 4))
	(ball (resultNumber ?x)(periodNumber ?p)(classID ?i))
	(ball (resultNumber ?x)(periodNumber ?p)(classID ?j))
	(ball (resultNumber ?x)(periodNumber ?p)(classID ?k))
	(test (and (not (eq ?i ?j))(not (eq ?i ?k)) (not (eq ?j ?k))     ))
	(course (classID ?i)(type compulsory))
	(course (classID ?j)(type compulsory))
	(course (classID ?k)(type compulsory))
	?f1 <- (result (resultNumber ?x)(SCORE ?point)(status done)(block ?w))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?x)(SCORE (- ?point 7))(status done2)(block ?w)) )
)


(defrule MAIN::status-done
	(declare (salience -1))
	?f1 <- (result (resultNumber ?a)(SCORE ?point)(status yet)(block ?w))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?a)(SCORE ?point)(status done2)(block ?w)) )
)
(defrule MAIN::status-done2
	(declare (salience -1))
	?f1 <- (result (resultNumber ?a)(SCORE ?point)(status done)(block ?w))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?a)(SCORE ?point)(status done2)(block ?w)) )
)

(defrule MAIN::teacher-repetition
	(declare (salience 5))
	?f1 <- (ball (resultNumber ?x)(periodNumber ?y)(classID ?j))
	?f2 <- (ball (resultNumber ?x)(periodNumber ?y)(classID ?k))
	(test (not (eq ?j ?k) ) )
	(course (classID ?j)(teacher $? ?t $?))
	(course (classID ?k)(teacher $? ?t $?))
	(test (not (eq ?t no) ) )	
	=>
	(assert (result-ToBeDeleted (num ?x) ))
)


(defrule MAIN::count-theLast-course
	(declare (salience 3))
	?f1 <- (result (resultNumber ?x)(SCORE ?y)(status yet0)(block ?w))
	(ball (resultNumber ?x)(classID ?z)(isLast yes))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?x)(SCORE ?y)(status yet)(block ?w)))
	(assert (courses-count (resultNumber ?x)(classID ?z)(amount (length$ (find-all-facts ((?f ball)) (and (eq ?f:resultNumber ?x)(eq ?f:classID ?z))  ) )   ) ) )
)
(defrule MAIN::course-equalAmount 
	(declare (salience 5))
	(courses-count (resultNumber ?x)(classID ?y)(amount ?z))
	(course (classID ?y)(period-needed ?pn))
	(test (= ?z ?pn))
	=>
	(assert (box-full (resultNumber ?x)(classID ?y) ))
)



(defrule MAIN::unavailable-period ;不可使用的時段
	(declare (salience 5))
	(unavailable-ball (grade ?g)(num $? ?un $?))
	(ball (resultNumber ?x)(periodNumber ?un)(grade ?g)(classID ?y))
	(course (name ?z)(classID ?y))
	(test  (not (eq ?z Empty) ))
	=>
	(assert (result-ToBeDeleted (num ?x)) )
)


(defrule MAIN::delete-result
	(declare (salience 6))
	(result-ToBeDeleted (num ?x))
	?f1 <- (result (resultNumber ?x))
	=>
	(retract ?f1)
)
(defrule MAIN::delete-ball
	(declare (salience 6))
	(result-ToBeDeleted (num ?x))
	?f1 <- (ball (resultNumber ?x))
	=>
	(retract ?f1)
)
(defrule MAIN::delete-clear ;這個rule是可以不用存在
	(declare (salience 1))
	?f1 <- (result-ToBeDeleted (num ?x))
	=>
	(retract ?f1)
)
(defrule MAIN::coursesCount-clear ;這個rule是可以不用存在
	(declare (salience 1))
	?f1 <- (courses-count (resultNumber ?x))
	=>
	(retract ?f1)
)

(defrule MAIN::finished
	(declare (salience -2))
	(result (resultNumber ?x)(status done2))
	(ball (resultNumber ?x)(periodNumber ?y)(grade ?z))
	(max-period ?y)
	(max-grade ?z)
	=>
	(assert (program-ctrl fin))
	(focus RESULT)
)

(defrule MAIN::exclusive-LOCK-off
	(declare (salience -3))
	(not (program-ctrl fin) )
	?f1 <- (exclusive-LOCK on)
	=>
	(retract ?f1)
	(assert (exclusive-LOCK off) )
)

;===================START OF ARRANGE===================
(defmodule ARRANGE
	(import MAIN ?ALL)
)

(deffacts ARRANGE::default-for-arrangement
	(rtable Empty) 
)
(defrule ARRANGE::expand-rtable
	(declare (salience 100))
	(course (name ?n))
	?f1 <- (rtable $?before)
	(test (not (member ?n ?before)))
	=>
	(retract ?f1)
	(assert (rtable ?before ?n))
)

(defrule ARRANGE::assign-resultNumber
	(declare (salience 5))
	?f1 <- (result (resultNumber Unassigned1)(SCORE ?x)(status ?status)(block ?w))
	?f2 <- (ball (resultNumber Unassigned2)(periodNumber ?y)(grade ?z)(classID ?a))
	=>
	(assert (result (resultNumber (fact-index ?f1))(SCORE ?x)(status ?status)(block ?w)) )
	(assert (ball (resultNumber (fact-index ?f1))(periodNumber ?y)(grade ?z)(classID ?a)(isLast yes)))
	(assert (copy-target (fact-index ?f1)))
	(retract ?f1)
	(retract ?f2)
)

(defrule ARRANGE::arranging-nextGrade
	(result-picked ?rN)
	(result (resultNumber ?rN)(SCORE ?x)(block ?w) )
	(ball (resultNumber ?rN)(periodNumber ?y)(grade ?z)(isLast yes) )
	;(min-grade ?min)
	(max-grade ?max)
	(test (not (eq ?z ?max)))
	(rtable $? ?newClass $?)
	(course (name ?newClass)(classID ?a)(grade ?zz))
	(test (eq (+ ?z 1) ?zz) )
	(not (box-full (resultNumber ?rN)(classID ?a)))
	=>
	(assert (result (resultNumber Unassigned1)(SCORE ?x)(status yet0)(block ?w)) )
	(assert (ball (resultNumber Unassigned2)(periodNumber ?y)(grade (+ ?z 1))(classID ?a)(isLast yes)))
)

(defrule ARRANGE::arranging-nextPeriod
	(result-picked ?rN)
	(result (resultNumber ?rN)(SCORE ?x)(block ?w) )
	(ball (resultNumber ?rN)(periodNumber ?y)(grade ?z)(isLast yes))
	(min-grade ?min)
	(max-grade ?max)
	(test (eq ?z ?max))
	(rtable $? ?newClass $?)
	(course (name ?newClass)(classID ?a)(grade ?min))
	(not (box-full (resultNumber ?rN)(classID ?a)))
	=>
	(assert (result (resultNumber Unassigned1)(SCORE ?x)(status yet0)(block ?w)) )
	(assert (ball (resultNumber Unassigned2)(periodNumber (+ ?y 1))(grade ?min)(classID ?a)))
)

(defrule ARRANGE::copy-ball
	(declare (salience 3))
	(result-picked ?rN)
	(ball (resultNumber ?rN)(periodNumber ?a)(grade ?b)(classID ?c))
	(copy-target ?newRN)
	=>
	(assert (ball (resultNumber ?newRN)(periodNumber ?a)(grade ?b)(classID ?c)))
)

(defrule ARRANGE::copy-box
	(declare (salience 3))
	(result-picked ?rN)
	(box-full (resultNumber ?rN)(classID ?c))
	(copy-target ?newRN)
	=>
	(assert (box-full (resultNumber ?newRN)(classID ?c)))
)

(defrule ARRANGE::end-of-copy
	(declare (salience 2))
	?f1 <- (copy-target ?x)
	=>
	(retract ?f1)
)

(defrule ARRANGE::ARRANGE-to-MAIN
	(declare (salience -2) )
	(result-picked ?x)
	=>
	(assert (result-ToBeDeleted (num ?x)))
	(focus MAIN)
)



;===================END OF ARRANGE===================


;===================START OF RESULT===================


(defmodule RESULT
	(import MAIN ?ALL)
	(export ?ALL)
)

(deftemplate RESULT::final-ball
	(slot resultNumber)
	(slot periodNumber)
	(slot grade)
	(slot classID)
	(slot isLast(default no)) ;yes or no
)
(deftemplate RESULT::final-result
	(slot resultNumber)
	(slot SCORE)
	(slot status) ;(SCORE yet or done)
	(slot block)
)
(deffacts RESULT::requirement
	(total-accountings 1500)
	(count 0)
)

(defrule RESULT::find-result-finished-B1
	(declare (salience 2))
	(program-ctrl fin)
	(result (resultNumber ?x)(status done2))
	(ball (resultNumber ?x)(periodNumber ?y)(grade ?z))
	(max-period ?y)
	(max-grade ?z)
	=>
	(assert (finished-resultNumber ?x))
	(assert (count-LOCK off))
)



(defrule RESULT::restore-result
	(declare (salience 5))
	(finished-resultNumber ?x)
	?f1 <- (result (resultNumber ?x)(SCORE ?b)(status ?c)(block ?w))
	=>
	(retract ?f1)
	(assert (final-result (resultNumber ?x)(SCORE ?b)(status ?c)(block ?w)) )
)
(defrule RESULT::restore-ball
	(declare (salience 5))
	(finished-resultNumber ?x)
	?f1 <- (ball (resultNumber ?x)(periodNumber ?b)(grade ?c)(classID ?d)(isLast ?e))
	=>
	(retract ?f1)
	(assert (final-ball (resultNumber ?x)(periodNumber ?b)(grade ?c)(classID ?d)(isLast ?e)))
)

(defrule RESULT::calculate-amount
	(declare (salience 3))
	?f1 <- (count-LOCK off)
	?f2 <- (count ?a)
	=>
	(retract ?f1)
	(retract ?f2)
	(assert (count (length$ (find-all-facts ((?f final-result)) (> ?f:resultNumber 0)))  ) )
)

(defrule RESULT::RESULT-to-MAIN
	(declare (salience -2))
	(total-accountings ?amount)
	(count ?a)
	(test (< ?a ?amount))
	?f1 <- (program-ctrl fin)
	=>
	(retract ?f1)
	(focus MAIN)
)

(defrule RESULT::Next-turn  ;目前以寫死的方式去寫，將來可考慮參數化
	(declare (salience -3))
	(total-accountings ?amount)
	(count ?a)
	(test (eq ?a ?amount))
	?f1 <- (now-turn B1)
	?f2 <- (min-grade 1)
	?f3 <- (max-grade 2)
	?f4 <- (total-accountings ?n)
	=>
	(retract ?f1 ?f2 ?f3 ?f4)
	(assert (total-accountings (* ?n 2)))
	(assert (signal (status on)))
)

(defrule RESULT::RESULT-to-COMBINE
	(declare (salience -7))
	=>
	(focus COMBINE)
)

;(defrule RESULT::Find-highest-SCORE-result
;	(declare (salience -3))
;	(total-accountings ?s)
;	(final-result (resultNumber ?x)(SCORE ?y))
;	(not (final-result (SCORE ?more&:(> ?more ?y))))
;	=>
;	(printout t "The higheset score is: " ?y " at Result number " ?x " With sample size " ?s crlf)
;)

;===================END OF RESULT===================

;===================START OF COMBINE===================
(defmodule COMBINE
	(import RESULT deftemplate final-result final-ball)
	(import MAIN deftemplate course)
)

(deftemplate COMBINE::now-pair
	(slot B1N)
	(slot B2N)
	(slot B3N)
)
(defrule COMBINE::pick-pair
	(declare (salience -2))
	(final-result (resultNumber ?x)(block B1))
	(final-result (resultNumber ?a)(block B2))
	=>
	(assert (pair ?x ?a))
)

(defrule COMBINE::set-newResultNumber
	(declare (salience 3))
	?f1 <- (pair ?x ?a)
	(final-result (resultNumber ?x)(SCORE ?i))
	(final-result (resultNumber ?a)(SCORE ?j))
	=>
	(assert (now-pair (B1N ?x)(B2N ?a)(B3N (fact-index ?f1))) )
	(assert (final-result (resultNumber (fact-index ?f1))(SCORE (+ ?i ?j))(status fin)(block B3)) )
)

(defrule COMBINE::load-in-B3
	(now-pair (B1N ?x)(B2N ?y)(B3N ?z))
	(final-ball (resultNumber ?a)(periodNumber ?b)(grade ?c)(classID ?d))
	(test (or (eq ?x ?a)(eq ?y ?a)))
	=>
	(assert (final-ball (resultNumber ?z)(periodNumber ?b)(grade ?c)(classID ?d)))
)

;(defrule COMBINE::nowPair-clear
;	(declare (salience -3))
;	?f1 <- (now-pair (B3N ?x))
;	=>
;	(retract ?f1)
;)
(defrule COMBINE::pair-clear
	(declare (salience -1))
	?f1 <- (pair ?x ?a)
	=>
	(retract ?f1)
)
(defrule COMBINE::finalDelete-clear
	(declare (salience -1))
	?f1 <- (final-delete ?x)
	=>
	(retract ?f1)
)

(defrule COMBINE::teacher-repetition-forFINAL
	(declare (salience 5))
	?f1 <- (final-ball (resultNumber ?x)(periodNumber ?y)(classID ?j))
	?f2 <- (final-ball (resultNumber ?x)(periodNumber ?y)(classID ?k))
	(test (not (eq ?j ?k) ) )
	(course (classID ?j)(teacher $? ?t $?))
	(course (classID ?k)(teacher $? ?t $?))
	(test (not (eq ?t no) ) )	
	=>
	(assert (final-delete ?x))
)

(defrule COMBINE::delete-result-forFINAL
	(declare (salience 6))
	(final-delete ?x)
	?f1 <- (final-result (resultNumber ?x))
	=>
	(retract ?f1)
)
(defrule COMBINE::delete-ball-forFINAL
	(declare (salience 6))
	(final-delete ?x)
	?f1 <- (final-ball (resultNumber ?x))
	=>
	(retract ?f1)
)
(defrule COMBINE::delete-nowPair-forFINAL
	(declare (salience 6))
	(final-delete ?x)
	?f1 <- (now-pair (B1N ?a)(B2N ?b)(B3N ?x))
	=>
	(retract ?f1)
)
(defrule COMBINE::delete-pair-forFINAL
	(declare (salience 6))
	(final-delete ?x)
	?f1 <- (pair ?a ?b)
	(test (eq (fact-index ?f1) ?x))
	=>
	(retract ?f1)
)

(defrule COMBINE::show-message-no
	(declare (salience -5))
	(not (final-result (block B3)))
	=>
	(printout t "No result in B3!" crlf)
)

(defrule COMBINE::show-message-yes
	(declare (salience -5))
	(final-result (block B3))
	=>
	(printout t "HAVE result in B3!!!" crlf)
)
;===================END OF COMBINE===================
