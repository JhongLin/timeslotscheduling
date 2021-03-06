(defmodule MAIN
   (export deftemplate ?ALL))
   
(deftemplate MAIN::course
   (slot name)
   (slot instructor)
   (multislot periods-offered)
   (slot instructor-bonus (default no))
   (slot period-bonus (default no))
   (slot instructor-penalty (default no))
   (slot period-penalty (default no))
   (slot score (default 0)))

(deftemplate MAIN::schedule
   (slot course)
   (multislot desired-instructors)
   (multislot undesired-instructors)
   (multislot desired-periods)   
   (multislot undesired-periods))

(deftemplate MAIN::scheduled
   (slot course)
   (slot instructor)
   (slot period))

(deffacts MAIN::test-data
   (schedule (course "Texas History")
             (desired-instructors Hill)
             (desired-periods 2 5)
             (undesired-periods 1 3))
   (schedule (course "Algebra")
             (desired-instructors Smith)
             (undesired-instructors Jones)
             (desired-periods 1 2)
             (undesired-periods 6))
   (schedule (course "Physical Education")
             (undesired-instructors Mack King)
             (undesired-periods 1))
   (schedule (course "Chemistry")
             (desired-instructors Dolby)
             (desired-periods 5 6))
   (schedule (course "Literature")
             (desired-periods 3 4)
             (undesired-periods 1 6))
   (schedule (course "German")))
                
(deffacts MAIN::course-information
   (course (name "Algebra")
           (instructor Jones)
           (periods-offered 1 2 3))
   (course (name "Algebra")
           (instructor Smith)
           (periods-offered 3 4 5 6))
   (course (name "American History")
           (instructor Vale)
           (periods-offered 5))
   (course (name "American History")
           (instructor Hill)
           (periods-offered 1 2))
   (course (name "Art")
           (instructor Jenkins)
           (periods-offered 1 3 5))
   (course (name "Biology")
           (instructor Dolby)
           (periods-offered 1 2 5))
   (course (name "Chemistry")
           (instructor Dolby)
           (periods-offered 3 6))
   (course (name "Chemistry")
           (instructor Vinson)
           (periods-offered 6))
   (course (name "French")
           (instructor Blake)
           (periods-offered 2 4))
   (course (name "Geology")
           (instructor Vinson)
           (periods-offered 1))
   (course (name "Geometry")
           (instructor Jones)
           (periods-offered 5 6))
   (course (name "Geometry")
           (instructor Smith)
           (periods-offered 1))
   (course (name "German")
           (instructor Blake)
           (periods-offered 5))
   (course (name "Literature")
           (instructor Henning)
           (periods-offered 2 3 4 5 6))
   (course (name "Literature")
           (instructor Davis)
           (periods-offered 1 2 3 4 5))
   (course (name "Music")
           (instructor Jenkins)
           (periods-offered 2 4))
   (course (name "Physical Education")
           (instructor Mack)
           (periods-offered 1 2 3 4 5))
   (course (name "Physical Education")
           (instructor King)
           (periods-offered 1 2 3 4 6))
   (course (name "Physical Education")
           (instructor Simpson)
           (periods-offered 2 3 4 5 6))
   (course (name "Physics")
           (instructor Vinson)
           (periods-offered 2 3 5))
   (course (name "Spanish")
           (instructor Blake)
           (periods-offered 1 3))
   (course (name "Texas History")
           (instructor Vale)
           (periods-offered 2 3 4))
   (course (name "Texas History")
           (instructor Hill)
           (periods-offered 5 6))
   (course (name "World History")
           (instructor Vale)
           (periods-offered 2 3 4))
   (course (name "World History")
           (instructor Hill)
           (periods-offered 4)))
 
(defrule MAIN::start
   =>
   (focus EXPAND SCORE PICK SUGGEST))

(defmodule EXPAND 
   (import MAIN deftemplate course))
   
(defrule EXPAND::single-period
   ?f <- (course (name ?name)
                 (instructor ?instructor)
                 (periods-offered ?first ?middle $?end))
   =>
   (modify ?f (periods-offered ?first))
   (duplicate ?f (periods-offered ?middle $?end)))
    
(defmodule SCORE
   (import MAIN deftemplate schedule course))
                          
(defrule SCORE::desired-instructor
   (schedule (course ?name)
             (desired-instructors $? ?instructor $?))
   ?f <- (course (name ?name)
                 (instructor ?instructor)
                 (score ?score)
                 (instructor-bonus no))
   =>
   (modify ?f (score (+ ?score 1))
              (instructor-bonus yes)))
   
(defrule SCORE::desired-period
   (schedule (course ?name)
             (desired-periods $? ?period $?))
   ?f <- (course (name ?name)
                 (periods-offered ?period)
                 (score ?score)
                 (period-bonus no))
   =>
   (modify ?f (score (+ ?score 1))
              (period-bonus yes)))
   
(defrule SCORE::undesired-instructor
   (schedule (course ?name)
             (undesired-instructors $? ?instructor $?))
   ?f <- (course (name ?name)
                 (instructor ?instructor)
                 (score ?score)
                 (instructor-penalty no))
   =>
   (modify ?f (score (- ?score 1))
              (instructor-penalty yes)))
      
 (defrule SCORE::undesired-period
   (schedule (course ?name)
             (undesired-periods $? ?period $?))
   ?f <- (course (name ?name)
                 (periods-offered ?period)
                 (score ?score)
                 (period-penalty no))
   =>
   (modify ?f (score (- ?score 1))
              (period-penalty yes)))
  
(defmodule PICK
   (import MAIN deftemplate schedule course scheduled initial-fact))
   
(defrule PICK::best-score
   (schedule (course ?name))
   (not (scheduled (course ?name)))
   (course (name ?name) 
           (score ?score)
           (periods-offered ?period)
           (instructor ?instructor))
   (not (scheduled (period ?period)))
   (not (and (course (name ?name)
                     (periods-offered ?period2)
                     (score ?score2&:(> ?score2 ?score)))
             (not (scheduled (period ?period2)))))
   =>
   (assert (scheduled (course ?name)
                      (instructor ?instructor)
                      (period ?period))))

(defrule PICK::swap-when-no-choice
   (schedule (course ?name))
   (not (scheduled (course ?name)))
   (not (and (course (name ?name) 
                     (periods-offered ?period))
             (not (scheduled (period ?period)))))
   ?f <- (scheduled (course ?other-name)
                    (period ?other-period))
   (course (name ?name)
           (periods-offered ?other-period)
           (instructor ?instructor)
           (score ?score1))
   (course (name ?other-name)
           (instructor ?another-instructor)
           (periods-offered ?another-period)
           (score ?score2))
   (not (scheduled (period ?another-period)))                      
   (not (and (scheduled (course ?other-name2)
                        (period ?other-period2))
        (course (name ?name)
                (periods-offered ?other-period2)
                (score ?score3))
        (course (name ?other-name2)
                (periods-offered ?another-period2)
                (score ?score4))
        (not (scheduled (period ?another-period2)))
        (test (> (+ ?score3 ?score4) (+ ?score1 ?score2)))))
   =>
   (assert (scheduled (course ?name)
                      (instructor ?instructor)
                      (period ?other-period)))
   (modify ?f (period ?another-period)
              (instructor ?another-instructor)))
 
(defrule PICK::swap-better-score
   ?f1 <- (scheduled (course ?name1)
                     (period ?period1)
                     (instructor ?instructor1))
   ?f2 <- (scheduled (course ?name2&~?name1)
                     (period ?period2)
                     (instructor ?instructor2))
   (course (name ?name1)
           (periods-offered ?period1)
           (instructor ?instructor1)
           (score ?score1))
   (course (name ?name2)
           (periods-offered ?period2)
           (instructor ?instructor2)
           (score ?score2))
   (course (name ?name1)
           (periods-offered ?period2)
           (instructor ?instructor3)
           (score ?score3))
   (course (name ?name2)
           (periods-offered ?period1)
           (instructor ?instructor4)
           (score ?score4))
   (test (> (+ ?score3 ?score4) (+ ?score1 ?score2)))
   =>
   (modify ?f1 (period ?period2)
               (instructor ?instructor3))
   (modify ?f2 (period ?period1)
               (instructor ?instructor4)))
   
(defmodule SUGGEST
   (import MAIN deftemplate scheduled initial-fact))
   
(defrule SUGGEST::print-schedule
   ?f <- (scheduled (course ?name)
                    (period ?period)
                    (instructor ?instructor))
   (not (scheduled (period ?period2&:(< ?period2 ?period))))
   =>
   (retract ?f)
   (printout t "For " ?name ", " ?instructor " in period " ?period
               " is suggested." crlf))
