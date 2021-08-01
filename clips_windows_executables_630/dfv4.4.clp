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

(deftemplate MAIN::box-full
	(slot resultNumber)
	(slot classID)
)
(deftemplate MAIN::cross-grade-course		;****新增部分****
	(slot classID)
	(multislot grade)
)

(deftemplate MAIN::result
	(slot resultNumber)
	(slot SCORE)
	(slot status) ;(SCORE yet or done)
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
	(result (resultNumber 0)(SCORE 0)(status done2) )
	(ball (resultNumber 0)(periodNumber 0)(grade 4)(isLast yes) ) ;default max grade
	
	
	(unavailable-ball (grade 1)(num 1 4 9 10))
	(unavailable-ball (grade 2)(num 1 4))
	(unavailable-ball (grade 3)(num 2 4))
	(unavailable-ball (grade 4)(num 4))
	(exclusive-LOCK off)
	(result-picked -1)
	
	(max-grade 4) ;在排列,finished的rule中會用到
	(max-period 10) ;finished的rule中會用到
	
	(cross-grade-course (classID 010087)(grade 3 4))
	(cross-grade-course (classID 010089)(grade 3 4))
	(cross-grade-course (classID 010090)(grade 3 4))
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
;===============================Grade 1===============================
	(course (name Programming)
			(classID 010074)
			(grade 1)
			(type compulsory)
			(period-needed 1)
			(desire-period 6)
			(undesire-period 3 4)
			(teacher 孔崇旭))
	(course (name Calculus-I)
			(classID 010071)
			(grade 1)
			(type compulsory)
			(period-needed 1)
			(desire-period 8)
			(undesire-period 5)
			(teacher 黃一泓))
	(course (name General-Physics)
			(classID 010072)
			(grade 1)
			(type compulsory)
			(period-needed 1)
			(desire-period 7)
			(undesire-period 10)
			(teacher 葉聰文))
	(course (name Introduction-to-Computer-Science)
			(classID 010073)
			(grade 1)
			(type compulsory)
			(period-needed 1)
			(desire-period 5)
			(undesire-period 6 8 10)
			(teacher 賴冠州))
	(course (name UNIX-Practices-and-Applications)
			(classID 010075)
			(grade 1)
			(type elective)
			(period-needed 1)
			(desire-period 3)
			(undesire-period 6)
			(teacher 蔡篤校))
			
			
			
;===============================Grade 2===============================		
	(course (name Linear-Algebra)
			(classID 010076)
			(grade 2)
			(type compulsory)
			(period-needed 1)
			(desire-period 8)
			(undesire-period 2 6 7)
			(teacher 黃政治))
	(course (name Data-Structure)
			(classID 010077)
			(grade 2)
			(type compulsory)
			(period-needed 1)
			(desire-period 3)
			(undesire-period 1 5)
			(teacher 張林煌))
	(course (name System-Programming-and-Assembler)
			(classID 010078)
			(grade 2)
			(type compulsory)
			(period-needed 1)
			(desire-period 1)
			(undesire-period 6 8 10)
			(teacher 黃國展))
	(course (name Object-oriented-Programming)
			(classID 010079)
			(grade 2)
			(type elective)
			(period-needed 1)
			(desire-period 7)
			(undesire-period 3 4)
			(teacher 孔崇旭))		
	(course (name System-Analysis-and-Design)
			(classID 010081)
			(grade 2)
			(type elective)
			(period-needed 1)
			(desire-period 9)
			(undesire-period 1 2)
			(teacher 徐國勛))		
	(course (name Introduction-to-the-Principles-of-Internet)
			(classID 010080)
			(grade 2)
			(type elective)
			(period-needed 1)
			(desire-period 5)
			(undesire-period 6)
			(teacher 林嬿雯))
			
			
			
			
			
			
;===============================Grade 3===============================
	(course (name Operating-System)
			(classID 010084)
			(grade 3)
			(type compulsory)
			(period-needed 1)
			(desire-period 2)
			(undesire-period 1)
			(teacher 林嬿雯))
	(course (name Computer-Organization)
			(classID 010083)
			(grade 3)
			(type compulsory)
			(period-needed 1)
			(desire-period 5)
			(undesire-period 3 4)
			(teacher 李宜軒))
	
	(course (name Compiler)
			(classID 010088)
			(grade 3)
			(type elective)
			(period-needed 1)
			(desire-period 9)
			(undesire-period 8)
			(teacher 李宜軒))	
	(course (name Network-Management-and-Analysis)
			(classID 010087)
			(grade 3)
			(type elective)
			(period-needed 1)
			(desire-period 6)
			(undesire-period 1 2)
			(teacher 李宗翰 張林煌))	
	(course (name Mobile-communication)
			(classID 010090)
			(grade 3)
			(type elective)
			(period-needed 1)
			(desire-period 7)
			(undesire-period 2 5)
			(teacher 王讚彬))	
	(course (name High-Performance-Computing)
			(classID 010085)
			(grade 3)
			(type elective)
			(period-needed 1)
			(desire-period 8)
			(undesire-period 6 10)
			(teacher 黃國展))	
	(course (name Embedded-System)
			(classID 010089)
			(grade 3)
			(type elective)
			(period-needed 1)
			(desire-period 3)
			(undesire-period 1)
			(teacher 李宗翰))	
			
			
;===============================Grade 4===============================
	;(course (name Network-Management-and-Analysis)
	;		(classID 010087)
	;		(grade 4)
	;		(type elective)
	;		(period-needed 1)
	;		(desire-period 6)
	;		(undesire-period 5 7)
	;		(teacher 李宗翰 張林煌))	
	;(course (name Mobile-communication)
	;		(classID 010090)
	;		(grade 4)
	;		(type elective)
	;		(period-needed 1)
	;		(desire-period 7)
	;		(undesire-period 5 8)
	;		(teacher 王讚彬))	
	;(course (name Embedded-System)
	;		(classID 010089)
	;		(grade 4)
	;		(type elective)
	;		(period-needed 1)
	;		(desire-period 3)
	;		(undesire-period 2)
	;		(teacher 李宗翰))
	(course (name Programming-for-Cloud-Computing)
			(classID 010094)
			(grade 4)
			(type elective)
			(period-needed 1)
			(desire-period 10)
			(undesire-period 6 8)
			(teacher 賴冠州))
			
			
;===============================空箱區===============================
	(course (name Empty)
			(classID K00)
			(grade 1)
			(type elective) 
			(period-needed 5)
			(teacher no))
	(course (name Empty)
			(classID K01)
			(grade 2)
			(type elective)
			(period-needed 4)
			(teacher no))
	(course (name Empty)
			(classID K02)
			(grade 3)
			(type elective) 
			(period-needed 3)
			(teacher no))
	(course (name Empty)
			(classID K03)
			(grade 4)
			(type elective)
			(period-needed 9)
			(teacher no))
)

(defrule MAIN::Pick-highest-SCORE-result
	?f1 <- (exclusive-LOCK off)
	?f2 <- (result (resultNumber ?x)(SCORE ?y)(status done2))
	(not (result (SCORE ?more&:(> ?more ?y))(status done2)))
	?f3 <- (result-picked ?z) ;?z now isn't used
	=>
	(retract ?f1)
	(assert (exclusive-LOCK on) )
	(retract ?f3)
	(assert (result-picked ?x) )
	(focus ARRANGE)
)

(defrule MAIN::SCORE-for-desirePeriod
	(declare (salience 3))
	?f1 <- (result (resultNumber ?a)(SCORE ?point)(status yet))
	(ball (resultNumber ?a)(periodNumber ?b)(grade ?c)(classID ?d)(isLast yes) )
	(course (classID ?d)(desire-period $? ?b $?))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?a)(SCORE (+ ?point 1))(status done)) )
)

(defrule MAIN::SCORE-for-UndesirePeriod
	(declare (salience 3))
	?f1 <- (result (resultNumber ?a)(SCORE ?point)(status yet))
	(ball (resultNumber ?a)(periodNumber ?b)(grade ?c)(classID ?d)(isLast yes) )
	(course (classID ?d)(undesire-period $? ?b $?))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?a)(SCORE (- ?point 2))(status done)) )
)

(defrule MAIN::double-compulsory
	(declare (salience 3))
	(ball (resultNumber ?x)(periodNumber ?p)(classID ?y))
	(ball (resultNumber ?x)(periodNumber ?p)(classID ?z))
	(test (not (eq ?y ?z)))
	(course (classID ?y)(type compulsory))
	(course (classID ?z)(type compulsory))
	?f1 <- (result (resultNumber ?x)(SCORE ?point)(status done))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?x)(SCORE (- ?point 3))(status done2)) )
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
	?f1 <- (result (resultNumber ?x)(SCORE ?point)(status done))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?x)(SCORE (- ?point 7))(status done2)) )
	
)


(defrule MAIN::status-done
	(declare (salience -1))
	?f1 <- (result (resultNumber ?a)(SCORE ?point)(status yet))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?a)(SCORE ?point)(status done2)) )
)
(defrule MAIN::status-done2
	(declare (salience -1))
	?f1 <- (result (resultNumber ?a)(SCORE ?point)(status done))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?a)(SCORE ?point)(status done2)) )
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

(defrule MAIN::lecture-limit-aDay  ;一天不得超過四堂課
	(declare (salience 5))
	?f1 <- (ball (resultNumber ?x)(periodNumber ?y1)(classID ?j)(isLast yes)) ;%2=0 isLast Node
	?f2 <- (ball (resultNumber ?x)(periodNumber ?y2)(classID ?k)) ;上述的前一個節點
	(test (eq (mod ?y1 2) 0) )
	(test (eq (- ?y1 1) ?y2) )
	(course (classID ?j)(teacher $? ?t $?))
	(course (classID ?k)(teacher $? ?t $?))
	(test (not (eq ?t no) ) )	
	=>
	(assert (result-ToBeDeleted (num ?x) ))
)

(defrule MAIN::count-theLast-course
	(declare (salience 3))
	?f1 <- (result (resultNumber ?x)(SCORE ?y)(status yet0))
	(ball (resultNumber ?x)(classID ?z)(isLast yes))
	=>
	(retract ?f1)
	(assert (result (resultNumber ?x)(SCORE ?y)(status yet)))
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

(defrule MAIN::cross-grade-course-handle ;合開課程的對應
	(declare (salience 5))
	(cross-grade-course (classID ?y)(grade ?f $?r))
	(ball (resultNumber ?x)(periodNumber ?p)(grade ?f1)(classID ?y)(isLast no))
	(ball (resultNumber ?x)(periodNumber ?p)(grade ?f2)(classID ?k)(isLast yes))
	(test  (not (eq ?f1 ?f2) ))
	(test (member ?f2 ?r))
	(course (name Empty)(classID ?e)(grade ?f2))
	(test  (not (eq ?e ?k) ))
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
	?f1 <- (result (resultNumber Unassigned1)(SCORE ?x)(status ?status))
	?f2 <- (ball (resultNumber Unassigned2)(periodNumber ?y)(grade ?z)(classID ?a))
	=>
	(assert (result (resultNumber (fact-index ?f1))(SCORE ?x)(status ?status)) )
	(assert (ball (resultNumber (fact-index ?f1))(periodNumber ?y)(grade ?z)(classID ?a)(isLast yes)))
	(assert (copy-target (fact-index ?f1)))
	(retract ?f1)
	(retract ?f2)
)

(defrule ARRANGE::arranging-nextGrade
	(result-picked ?rN)
	(result (resultNumber ?rN)(SCORE ?x) )
	(ball (resultNumber ?rN)(periodNumber ?y)(grade ?z)(isLast yes) )
	(max-grade ?max)
	(test (not (eq ?z ?max)))
	(rtable $? ?newClass $?)
	(course (name ?newClass)(classID ?a)(grade ?zz))
	(test (eq (+ ?z 1) ?zz) )
	(not (box-full (resultNumber ?rN)(classID ?a)))
	=>
	(assert (result (resultNumber Unassigned1)(SCORE ?x)(status yet0)) )
	(assert (ball (resultNumber Unassigned2)(periodNumber ?y)(grade (+ ?z 1))(classID ?a)(isLast yes)))
)

(defrule ARRANGE::arranging-nextPeriod
	(result-picked ?rN)
	(result (resultNumber ?rN)(SCORE ?x) )
	(ball (resultNumber ?rN)(periodNumber ?y)(grade ?z)(isLast yes))
	(max-grade ?max)
	(test (eq ?z ?max))
	(rtable $? ?newClass $?)
	(course (name ?newClass)(classID ?a)(grade 1))
	(not (box-full (resultNumber ?rN)(classID ?a)))
	=>
	(assert (result (resultNumber Unassigned1)(SCORE ?x)(status yet0)) )
	(assert (ball (resultNumber Unassigned2)(periodNumber (+ ?y 1))(grade 1)(classID ?a)))
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
)
(deffacts RESULT::requirement
	(total-accountings 100)
	(count 0)
)




(defrule RESULT::find-result-finished
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
	?f1 <- (result (resultNumber ?x)(SCORE ?b)(status ?c))
	=>
	(retract ?f1)
	(assert (final-result (resultNumber ?x)(SCORE ?b)(status ?c)) )
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


(defrule RESULT::Find-highest-SCORE-result
	(declare (salience -3))
	(total-accountings ?s)
	(final-result (resultNumber ?x)(SCORE ?y))
	(not (final-result (SCORE ?more&:(> ?more ?y))))
	=>
	(printout t "The higheset score is: " ?y " at Result number " ?x " With sample size " ?s crlf)
)

;===================END OF RESULT===================