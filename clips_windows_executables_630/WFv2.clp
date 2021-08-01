(defmodule MAIN
   (export ?ALL)
)

(deftemplate MAIN::ptable
	(slot state)
	(slot grade) ;new attr.
	(slot father) ;new attr.
	(multislot classSerial)
	(slot score)
	(slot hide)
	(multislot scored-or-not)
	
	
)

(deftemplate MAIN::count
	(slot no)
	(slot amount)
)

(deftemplate MAIN::course
	(slot name)
	(slot grade)
	(slot type)
	(slot period-needed)
	(multislot desire-period)
	(multislot undesire-period)
	(slot teacher)
	;(slot referenced-bonus)
	;(slot referenced-penalty)
	
)

(deffacts MAIN::course-data
	(course (name A)
			
			(grade 1)
			(type compulsory)
			(period-needed 2)
			(desire-period 1 2)
			(undesire-period 2)
			(teacher EROS)
		;	(referenced-bonus 0)
		;	(referenced-penalty 0)
	)
	(course (name B)
			
			(grade 1)
			(type elective)
			(period-needed 2)
			(desire-period 5 6)
			(undesire-period 3)
			(teacher LILY)
		;	(referenced-bonus 0)
		;	(referenced-penalty 0)
	)
	(course (name C)
			
			(grade 1)
			(type elective)
			(period-needed 1)
			(desire-period 10)
			(undesire-period 1)
			(teacher ZODIAC)
		;	(referenced-bonus 0)
		;	(referenced-penalty 0)
	)
	(course (name D)
			
			(grade 1)
			(type elective)
			(period-needed 3)
			(desire-period 7 8 9)
			(undesire-period 1)
			(teacher YUGA)
		;	(referenced-bonus 0)
		;	(referenced-penalty 0)
	)
	(course (name E)
			
			(grade 2)
			(type elective)
			(period-needed 2)
			(desire-period 2 3)
			(undesire-period 4)
			(teacher AFU)
		;	(referenced-bonus 0)
		;	(referenced-penalty 0)
	)
	(course (name F)
			
			(grade 2)
			(type compulsory)
			(period-needed 2)
			(desire-period 7 8)
			(undesire-period 1)
			(teacher EROS)
		;	(referenced-bonus 0)
		;	(referenced-penalty 0)
	)
	(course (name G)
			
			(grade 2)
			(type elective)
			(period-needed 1)
			(desire-period 1)
			(undesire-period 1)
			(teacher LILY)
		;	(referenced-bonus 0)
		;	(referenced-penalty 0)
	)
	(course (name H)
			
			(grade 2)
			(type elective)
			(period-needed 3)
			(desire-period 4 5 6)
			(undesire-period 1)
			(teacher ZODIAC)
		;	(referenced-bonus 0)
		;	(referenced-penalty 0)
	)

	(course (name Empty1)
			
			(grade 1)
			(type elective) 
			(period-needed 2)
			(teacher nil)
		;	(referenced-bonus 0)
		;	(referenced-penalty 0)
	)
	(course (name Empty2)
			
			(grade 2)
			(type elective)
			(period-needed 2)
			(teacher nil)
		;	(referenced-bonus 0)
		;	(referenced-penalty 0)
	)
	
)

(deffacts MAIN::default
	(rtable A B C D E F G H Empty1 Empty2)
	
	(max-grade 2) ;new attr.
	
	(time 10)
	
	(ptable (state 1)(grade 1)(classSerial # 1)(score 0)(hide 0)(scored-or-not 1) )

	(current-state  1)
	(current-grade  1)
	
	
	
	(count (no 1)(amount 0))
	(max-score -10)
)

(defrule MAIN::start
   =>
   (focus SCHEDULE))


;===================START OF SCHEDULE===================

(defmodule SCHEDULE
	(import MAIN ?ALL)
)




;(defrule SCHEDULE::unlock 
	
;)



(defrule SCHEDULE::seperate-desire-and-undesire-period
	(declare (salience 5))
	?f <- (course (name ?name)(desire-period $?period1)(undesire-period $?period2))
	(test (not (or (member nil ?period1 )(member nil ?period2))))
	=>
	(modify ?f (desire-period nil))
	(modify ?f (undesire-period nil))
)
(defrule SCHEDULE::single-undesire-period
	(declare (salience 4))
   ?f <- (course (undesire-period ?first ?middle $?end))
   =>
   (modify ?f (undesire-period ?first))
   (duplicate ?f (undesire-period ?middle $?end))
)

(defrule SCHEDULE::single-desire-period
	(declare (salience 4))
   ?f <- (course (desire-period ?first ?middle $?end))
   =>
   (modify ?f (desire-period ?first))
   (duplicate ?f (desire-period ?middle $?end))
)

(defrule SCHEDULE::delete-node-used-firstGRADE ;利用code Gen.設定 一年級 的總共課堂數(含空箱)
	(declare (salience 3))
	(ptable (grade 2)(father ?x)(classSerial $?A)(hide 0))
	(ptable (grade 2)(father ?x)(classSerial $?B)(hide 0))
	(ptable (grade 2)(father ?x)(classSerial $?C)(hide 0))
	(ptable (grade 2)(father ?x)(classSerial $?D)(hide 0))
	(ptable (grade 2)(father ?x)(classSerial $?E)(hide 0))
	;(ptable (father ?x)(classSerial $?D))
	(test (not (or (eq ?A ?B)(eq ?A ?C)(eq ?A ?D)(eq ?A ?E)(eq ?B ?C)(eq ?B ?D)(eq ?B ?E)(eq ?C ?D)(eq ?C ?E)(eq ?D ?E)  ) ) )
	;(test (not (or (eq ?A ?B)(eq ?A ?C)(eq ?B ?C)  ) ) )
	
	?f1 <-(ptable)
	(test (eq (fact-index ?f1) ?x) )
	
	=>
	(retract ?x)
)

(defrule SCHEDULE::delete-node-used-secondGRADE ;利用code Gen.設定 二年級 的總共課堂數(含空箱)
	(declare (salience 3))
	(ptable (grade 3)(father ?x)(classSerial $?A)(hide 0))
	(ptable (grade 3)(father ?x)(classSerial $?B)(hide 0))
	(ptable (grade 3)(father ?x)(classSerial $?C)(hide 0))
	(ptable (grade 3)(father ?x)(classSerial $?D)(hide 0))
	(ptable (grade 3)(father ?x)(classSerial $?E)(hide 0))
	;(ptable (father ?x)(classSerial $?D))
	(test (not (or (eq ?A ?B)(eq ?A ?C)(eq ?A ?D)(eq ?A ?E)(eq ?B ?C)(eq ?B ?D)(eq ?B ?E)(eq ?C ?D)(eq ?C ?E)(eq ?D ?E)  ) ) )
	;(test (not (or (eq ?A ?B)(eq ?A ?C)(eq ?B ?C)  ) ) ) ;迪摩根定理: - (A or B or C) = (A and B and C) 用來測試三個都不一樣
	;(test (not (eq ?A ?B) )  )
	
	?f1 <-(ptable)
	(test (eq (fact-index ?f1) ?x) )
	
	=>
	(retract ?x)
)

(defrule SCHEDULE::repetition-handle-zero ;不得超過零個
	(declare (salience -1))
	(course (name ?x)(period-needed ?y))
	?f1 <- (ptable (classSerial $? ?x $?)(hide 0))
	(test (and (not (eq ?x #) )(eq ?y 0) ) ) ; x!=# and y=0
	=>
	(retract ?f1)
)

(defrule SCHEDULE::repetition-handle-one ;不得超過一個
	(declare (salience -1))
	(course (name ?x)(period-needed ?y))
	?f1 <- (ptable (classSerial $? ?x $? ?x $?)(hide 0))
	(test (and (not (eq ?x #) )(eq ?y 1) ) ) ; x!=# and y=1
	=>
	(retract ?f1)
)

(defrule SCHEDULE::repetition-handle-two ;不得超過二個
	(declare (salience -1))
	(course (name ?x)(period-needed ?y))
	?f1 <- (ptable (classSerial $? ?x $? ?x $? ?x $?)(hide 0))
	(test (and (not (eq ?x #) )(eq ?y 2) ) ) ; x!=# and y=2
	=>
	(retract ?f1)
)

(defrule SCHEDULE::repetition-handle-three ;不得超過三個
	(declare (salience -1))
	(course (name ?x)(period-needed ?y))
	?f1 <- (ptable (classSerial $? ?x $? ?x $? ?x $? ?x $?)(hide 0))
	(test (and (not (eq ?x #) )(eq ?y 3) ) ) ; x!=# and y=2
	=>
	(retract ?f1)
)

(defrule SCHEDULE::delete-teacher-repetition
	(declare (salience -1))
	?f1 <- (ptable (classSerial $? ?S ?x $? ?a $? ?b $? ?S ?y $?) (hide 0)) 
	(test (and (eq ?S #)(eq ?y (+ ?x 1) ) ) ) 
	(course (name ?a)(teacher ?c) ) 
	(course (name ?b)(teacher ?c) )
	=>
	(retract ?f1)
)

(defrule SCHEDULE::check-undesire-period
	(declare (salience -1))
	?f1 <- (ptable (classSerial $? ?S ?x $?b ?a)(score ?score)(hide 0)(scored-or-not $?scored-or-not))
	(test (not (member undesire-conflict ?scored-or-not )))
	(test (not (member ALL-conflict ?scored-or-not )))
	(test (and (eq ?S #)(not (eq ?a #)) ) )  
	(test (not (member # ?b)))
	(course (name ?a)(undesire-period ?x))
	
	=>
	(modify ?f1 (score (- ?score 2))(scored-or-not ?scored-or-not undesire-conflict))
	
)

(defrule SCHEDULE::check-desire-period
	(declare (salience -1))
	?f1 <-(ptable (classSerial $? ?S ?x $?b ?a)(score ?score)(hide 0)(scored-or-not $?scored-or-not))
	(test (not (member desire-conflict ?scored-or-not )))
	(test (not (member ALL-conflict ?scored-or-not )))
	(test (and (eq ?S #)(not (eq ?a #)) ) )  
	(test (not (member # ?b)))
	(course (name ?a)(desire-period ?x))
	=>
	(modify ?f1 (score (+ ?score 1))(scored-or-not ?scored-or-not desire-conflict))
	
	
	
)

(defrule SCHEDULE::check-for-compulsory
	(declare (salience -1))
	?f <- (ptable (classSerial $? ?S ?x $?course)(score ?score)(hide 0)(scored-or-not $?scored-or-not))
	(test (not (member compulsory-conflict ?scored-or-not )))
	(test (not (member ALL-conflict ?scored-or-not )))
	(test (eq ?S #))
	(test (not (member # ?course)))
	(course (name ?name1)(type compulsory))
	(course (name ?name2)(type compulsory))
	(test (not (eq ?name1 ?name2)))
	(test (and (member ?name1 ?course) (member ?name2 ?course)))
	=>
	(modify ?f (score (- ?score 2))(scored-or-not ?scored-or-not compulsory-conflict))
)
(defrule SCHEDULE::select-highest-score
	(declare (salience 1))
	?f <- (max-score ?max-score)
	(ptable (state ?state)(score ?score1)(hide 0))
	(not (ptable (score ?score2&:(> ?score2 ?score1))(hide 0)))
	(test (> ?state 0))
	(test (not (eq ?score1 ?max-score)))
	=>
	(retract ?f)
	(assert (max-score ?score1))
)
(defrule SCHEDULE::hide-low-score
	(declare (salience -2))
	(max-score ?max-score)
	?f <- (ptable (state ?state)(score ?score)(hide 0))

	(test (> ?state 0))
	(test (< ?score ?max-score))
	=>
	(modify ?f (hide 1))
)

(defrule SCHEDULE::unlock
	(not (ptable (hide 0)))
	(max-grade ?max-grade)
	;?f <- (ptable (hide 1))
	?f <- (ptable (state ?state)(grade ?grade)(classSerial $? ?x ?state $?course)(hide 1))
	(test (eq ?x #))
	
	?f1 <- (current-state ?)
	?f2 <- (current-grade ?)
	=>
	(modify ?f (hide 0)(scored-or-not ALL-conflict))
	(retract ?f1 ?f2)
	(assert (current-state ?state))
	(if (< (length$ ?course) ?max-grade) then (assert (current-grade ?grade)))
	(if (eq (length$ ?course) ?max-grade) then (assert (current-grade (- ?grade 1))))
	
)

;(defrule SCHEDULE::unlock-for-next-segment
;	(not (ptable (hide 0)))
;	(max-grade ?max-grade)
;	;?f <- (ptable (hide 1))
;	?f <- (ptable (state ?state)(grade ?grade)(classSerial $? ?x ?state $?course)(hide 1))
;	(test (eq ?x #))
;	(test (eq (length$ ?course) ?max-grade))
;	?f1 <- (current-state ?)
;	?f2 <- (current-grade ?)
;	=>
;	(modify ?f (hide 0))
;	(retract ?f1 ?f2)
;	(assert (current-grade (- ?grade 1)))
;	(assert (current-state ?state))
	
;)

(defrule SCHEDULE::arrange
	(current-state ?x) 	
	(current-grade ?y)
	?f1 <- (ptable (state ?x)(grade ?y)(classSerial $?oldSerial)(score ?score)(hide 0))
	(test (> ?x -1) )
	(rtable $? ?z $?)
	(course (name ?z)(grade ?y))
	=>
	(assert (ptable (state ?x)(grade (+ ?y 1) )(father (fact-index ?f1))(classSerial ?oldSerial ?z)(score ?score)(hide 0) (scored-or-not 0)) )
)



(defrule SCHEDULE::change-grade
	(declare (salience -3) )
	?f1 <- (current-grade ?x)
	(max-grade ?y)
	(test  (< ?x ?y) )
	=>
	(retract ?f1)
	(assert (current-grade (+ ?x 1) ) )
)

(defrule SCHEDULE::segment
	(declare (salience -4) )
	(current-state ?x)
	(current-grade ?i)
	(max-grade ?max-grade)
	?f1 <- (ptable (state ?x)(grade ?k)(father ?daddy)(classSerial $?oldSerial ?y)(score ?score)(hide 0)(scored-or-not $?scored-or-not))
	;?f1 <- (ptable (state ?x)(grade ?k)(father ?daddy)(classSerial $?oldSerial ?a ?b $?c)(score ?score)(hide 0) )
	(test (not (eq (+ ?x 1) ?y) ) )
	;(test (eq ?a #))
	;(test (eq (length$ ?c) ?max-grade))
	(test (eq ?k (+ ?i 1) ) )
	=>
	(retract ?f1)
	(assert (ptable (state (+ ?x 1) )(grade 1)(father ?daddy)(classSerial $?oldSerial ?y # (+ ?x 1) )(score ?score) (hide 0)(scored-or-not ?scored-or-not)) )
)

(defrule SCHEDULE::calculate-count
	(declare (salience -1 ) )
	(current-state ?x)
	?f1 <- (count (no ?x)(amount ?y))
	=>
	(retract ?f1)
	(assert (count (no (+ 1 ?x))(amount    (length$ (find-all-facts ((?f ptable)) (> ?f:state (+ 1 ?x) )  ) )    ) ) )
)

(defrule SCHEDULE::finished
	(declare (salience -5) )
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


