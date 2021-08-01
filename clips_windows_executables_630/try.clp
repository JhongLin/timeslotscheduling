(defmodule MAIN
   (export ?ALL))
   
(deftemplate MAIN::result ;以此rule之fact編號為resultNumber
	(slot resultNumber)
	(slot SCORE)
	(slot grade)
	(slot serial)
)

(deffacts MAIN::test
	(result (resultNumber unknown))
	(result-picked -1)
	(result (resultNumber 1)(SCORE 3)(grade 1)(serial 7))
	(result (resultNumber 1)(SCORE 4)(grade 6)(serial 6))
	(result (resultNumber 1)(SCORE 5)(grade 8)(serial 7))
	(n 1)
)
(defrule MAIN::GOTRY
	=>
	(focus TRY)
)


(defmodule TRY
   (import MAIN ?ALL)
   (export ?ALL))

   
(deftemplate TRY::copy
	(slot resultNumber)
	(slot SCORE)
	(slot grade)
	(slot serial)
)
(deftemplate TRY::count
	(slot num)
)
   
   
(defrule TRY::testle
	=>
	(assert (count (num (length$ (find-all-facts ((?f result)) (and(eq ?f:resultNumber 1)(> ?f:grade 5)) )  ) ))  )
	

	
)

(defmodule KEN
   (import TRY deftemplate count))
   
   
