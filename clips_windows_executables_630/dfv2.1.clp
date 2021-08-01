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

(deffacts MAIN::default
	(result (resultNumber 0)(SCORE 0)(status done2) )
	(ball (resultNumber 0)(periodNumber 0)(grade 4)(isLast yes) ) ;default max grade
	
	
	(unavailable-ball (grade 1)(num 1 2 3 4 13 14 15 16 33 34 35 36 37 38 39 40))
	(unavailable-ball (grade 2)(num 1 2 3 4 13 14 15 16))
	(unavailable-ball (grade 3)(num 5 6 7 8 13 14 15 16))
	(unavailable-ball (grade 4)(num 13 14 15 16))
	(exclusive-LOCK off)
	(result-picked -1)
	
	(max-grade 4) ;在排列,finished的rule中會用到
	(max-period 40) ;finished的rule中會用到
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
			(period-needed 3)
			(desire-period 21 22 23)
			(undesire-period 1 17 33 9 10 11 12 25 26 27 28)
			(teacher 孔崇旭))
	(course (name Calculus-I)
			(classID 010071)
			(grade 1)
			(type compulsory)
			(period-needed 3)
			(desire-period 29 30 31)
			(undesire-period 1 9 25 33 10 11 12 17 18 19 20)
			(teacher 黃一泓))
	(course (name General-Physics)
			(classID 010072)
			(grade 1)
			(type compulsory)
			(period-needed 3)
			(desire-period 26 27 28)
			(undesire-period 1 9 17 25 33 5 6 7 8 37 38 39 40)
			(teacher 葉聰文))
	(course (name Introduction-to-Computer-Science)
			(classID 010073)
			(grade 1)
			(type compulsory)
			(period-needed 3)
			(desire-period 18 19 20)
			(undesire-period 1 9 17 25 33 21 22 23 24 29 30 31 32 37 38 39 40)
			(teacher 賴冠州))
	(course (name UNIX-Practices-and-Applications)
			(classID 010075)
			(grade 1)
			(type elective)
			(period-needed 3)
			(desire-period 10 11 12)
			(undesire-period 1 9 17 25 33)
			(teacher 蔡篤校))
			
			
			
;===============================Grade 2===============================		
	(course (name Linear-Algebra)
			(classID 010076)
			(grade 2)
			(type compulsory)
			(period-needed 3)
			(desire-period 29 30 31)
			(undesire-period 1 9 17 25 33)
			(teacher 黃政治))
	(course (name Data-Structure)
			(classID 010077)
			(grade 2)
			(type compulsory)
			(period-needed 3)
			(desire-period 10 11 12)
			(undesire-period 1 9 17 25 33)
			(teacher 張林煌))
	(course (name System-Programming-and-Assembler)
			(classID 010078)
			(grade 2)
			(type compulsory)
			(period-needed 3)
			(desire-period 2 3 4)
			(undesire-period 1 9 17 25 33)
			(teacher 黃國展))
	(course (name Object-oriented-Programming)
			(classID 010079)
			(grade 2)
			(type elective)
			(period-needed 3)
			(desire-period 26 27 28)
			(undesire-period 1 9 17 25 33)
			(teacher 孔崇旭))		
	(course (name System-Analysis-and-Design)
			(classID 010081)
			(grade 2)
			(type elective)
			(period-needed 3)
			(desire-period 34 35 36)
			(undesire-period 1 9 17 25 33)
			(teacher 徐國勛))		
	(course (name Introduction-to-the-Principles-of-Internet)
			(classID 010080)
			(grade 2)
			(type elective)
			(period-needed 3)
			(desire-period 18 19 20)
			(undesire-period 1 9 17 25 33)
			(teacher 林嬿雯))
			
			
			
			
			
			
;===============================Grade 3===============================
	(course (name Operating-System)
			(classID 010084)
			(grade 3)
			(type compulsory)
			(period-needed 3)
			(desire-period 5 6 7)
			(undesire-period 1 9 17 25 33)
			(teacher 林嬿雯))
	(course (name Computer-Organization)
			(classID 010083)
			(grade 3)
			(type compulsory)
			(period-needed 3)
			(desire-period 18 19 20)
			(undesire-period 1 9 17 25 33)
			(teacher 李宜軒))
	
	(course (name Compiler)
			(classID 010088)
			(grade 3)
			(type elective)
			(period-needed 3)
			(desire-period 34 35 36)
			(undesire-period 1 9 17 25 33)
			(teacher 李宜軒))	
	(course (name Network-Management-and-Analysis)
			(classID 010087)
			(grade 3)
			(type elective)
			(period-needed 3)
			(desire-period 21 22 23)
			(undesire-period 1 9 17 25 33)
			(teacher 李宗翰 張林煌))	
	(course (name Mobile-communication)
			(classID 010090)
			(grade 3)
			(type elective)
			(period-needed 3)
			(desire-period 26 27 28)
			(undesire-period 1 9 17 25 33)
			(teacher 王讚彬))	
	(course (name High-Performance-Computing)
			(classID 010085)
			(grade 3)
			(type elective)
			(period-needed 3)
			(desire-period 30 31 32)
			(undesire-period 1 9 17 25 33 29)
			(teacher 黃國展))	
	(course (name Embedded-System)
			(classID 010089)
			(grade 3)
			(type elective)
			(period-needed 3)
			(desire-period 10 11 12)
			(undesire-period 1 9 17 25 33)
			(teacher 李宗翰))	
			
			
;===============================Grade 4===============================
	(course (name Network-Management-and-Analysis)
			(classID 010087)
			(grade 4)
			(type elective)
			(period-needed 3)
			(desire-period 21 22 23)
			(undesire-period 1 9 17 25 33)
			(teacher 李宗翰 張林煌))	
	(course (name Mobile-communication)
			(classID 010090)
			(grade 3)
			(type elective)
			(period-needed 3)
			(desire-period 26 27 28)
			(undesire-period 1 9 17 25 33)
			(teacher 王讚彬))	
	(course (name Embedded-System)
			(classID 010089)
			(grade 3)
			(type elective)
			(period-needed 3)
			(desire-period 10 11 12)
			(undesire-period 1 9 17 25 33)
			(teacher 李宗翰))			
	(course (name Programming-for-Cloud-Computing)
			(classID 010094)
			(grade 3)
			(type elective)
			(period-needed 3)
			(desire-period 38 39 40)
			(undesire-period 1 9 17 25 33)
			(teacher 賴冠州))
			
			
;===============================空箱區===============================
	(course (name Empty)
			(classID K00)
			(grade 1)
			(type elective) 
			(period-needed 25)
			(teacher no))
	(course (name Empty)
			(classID K01)
			(grade 2)
			(type elective)
			(period-needed 22)
			(teacher no))
	(course (name Empty)
			(classID K02)
			(grade 3)
			(type elective) 
			(period-needed 19)
			(teacher no))
	(course (name Empty)
			(classID K03)
			(grade 4)
			(type elective)
			(period-needed 28)
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
	(assert (result (resultNumber ?x)(SCORE (- ?point 2))(status done2)) )
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
	(assert (result (resultNumber ?x)(SCORE (- ?point 5))(status done2)) )
	
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

(defrule MAIN::course-amount-over-zero ;可能每種需要的不同課程數量都需要額外多寫一個rule!!
	(declare (salience 5))
	(ball (resultNumber ?x)(periodNumber ?y)(classID ?z))
	(course (classID ?z)(period-needed 0))
	=>
	(assert (result-ToBeDeleted (num ?x)) )
)
(defrule MAIN::course-amount-over-one ;可能每種需要的不同課程數量都需要額外多寫一個rule!!
	(declare (salience 5))
	(ball (resultNumber ?x)(periodNumber ?y)(classID ?z))
	(ball (resultNumber ?x)(periodNumber ?i)(classID ?z))
	(test (not (eq ?i ?y)))
	(course (classID ?z)(period-needed 1))
	=>
	(assert (result-ToBeDeleted (num ?x)) )
)
(defrule MAIN::course-amount-over-two ;可能每種需要的不同課程數量都需要額外多寫一個rule!!
	(declare (salience 5))
	(ball (resultNumber ?x)(periodNumber ?y)(classID ?z))
	(ball (resultNumber ?x)(periodNumber ?i)(classID ?z))
	(ball (resultNumber ?x)(periodNumber ?j)(classID ?z))
	(test (and (not (eq ?y ?i))(not (eq ?y ?j))(not (eq ?i ?j))   ))
	(course (classID ?z)(period-needed 2))
	=>
	(assert (result-ToBeDeleted (num ?x)) )
)
(defrule MAIN::course-amount-over-three ;可能每種需要的不同課程數量都需要額外多寫一個rule!!
	(declare (salience 5))
	(ball (resultNumber ?x)(periodNumber ?y)(classID ?z))
	(ball (resultNumber ?x)(periodNumber ?i)(classID ?z))
	(ball (resultNumber ?x)(periodNumber ?j)(classID ?z))
	(ball (resultNumber ?x)(periodNumber ?k)(classID ?z))
	(course (classID ?z)(period-needed 3))
	(test (and (not (eq ?y ?i))(not (eq ?y ?j))(not (eq ?y ?k))(not (eq ?i ?j))(not (eq ?i ?k))(not (eq ?j ?k))   ))
	=>
	(assert (result-ToBeDeleted (num ?x)) )
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

(defrule MAIN::finished
	(declare (salience -2))
	(result (resultNumber ?x)(status done2))
	(ball (resultNumber ?x)(periodNumber ?y)(grade ?z))
	(max-period ?y)
	(max-grade ?z)
	=>
	(assert (program-ctrl fin))
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
	=>
	(assert (result (resultNumber Unassigned1)(SCORE ?x)(status yet)) )
	(assert (ball (resultNumber Unassigned2)(periodNumber ?y)(grade (+ ?z 1))(classID ?a)))
)

(defrule ARRANGE::arranging-nextPeriod
	(result-picked ?rN)
	(result (resultNumber ?rN)(SCORE ?x) )
	(ball (resultNumber ?rN)(periodNumber ?y)(grade ?z)(isLast yes))
	(max-grade ?max)
	(test (eq ?z ?max))
	(rtable $? ?newClass $?)
	(course (name ?newClass)(classID ?a)(grade 1))
	=>
	(assert (result (resultNumber Unassigned1)(SCORE ?x)(status yet)) )
	(assert (ball (resultNumber Unassigned2)(periodNumber (+ ?y 1))(grade 1)(classID ?a)))
)

(defrule ARRANGE::copy
	(declare (salience 3))
	(result-picked ?rN)
	(ball (resultNumber ?rN)(periodNumber ?a)(grade ?b)(classID ?c))
	(copy-target ?newRN)
	=>
	(assert (ball (resultNumber ?newRN)(periodNumber ?a)(grade ?b)(classID ?c)))
)

(defrule ARRANGE::end-of-copy
	(declare (salience 2))
	?f1 <- (copy-target ?x)
	=>
	(retract ?f1)
)

(defrule ARRANGE::back-to-MAIN
	(declare (salience -2) )
	(result-picked ?x)
	=>
	(assert (result-ToBeDeleted (num ?x)))
	(focus MAIN)
)



;===================END OF ARRANGE===================