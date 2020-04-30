; Domain definition for food preparation project
; MET CS 644
; Steve Shoyer
; April 30, 2020

(define (domain food-prep-7)
  (:requirements :strips :typing)

  (:types
    list resource - object ; base types
    food person equipment - resource      ; types of resources to be managed
    meal ingredient - food     ; raw ingredients and finished meal
    stove grill oven pan pot - equipment     ; types of equipment used to cook
    chef - person    ; person to prepare food
    inventory - list  ; ingredients need to be on the inventory list
  )

  (:predicates
    (on-hand ?i - ingredient ?l - inventory) ; ingredient ?i is in inventory ?l
    (on-order ?i - ingredient ?l - shopping-list)  ; ingredient ?i is on shopping list ?l
    (scheduled ?c - chef)  ; chef ?c is scheduled to work
    (can-cook ?c - chef ?m - meal)  ; chef ?c can cook meal ?m
    (available-stove ?e - stove)  ; stove ?e is available for use
    (available-grill ?e - grill)  ; grill ?e is available for use
    (available-oven ?e - oven)  ; oven ?e is available for use
    (available-pizza-pan ?e - pan)  ; pizza pan ?e is available for use
	(available-pot ?e - pot)  ; pot is available for use
    (prepared ?m - meal)  ; meal ?m has been prepared
    (updated ?l - list)  ; list ?l has been updated
	(prepped ?i - ingredient)  ; ingredient ?i is prepped
	(gets-prepped ?i - ingredient)  ; ingredient ?i gets prepped
	(mixed ?i - ingredient)  ; ingredient ?i is mixed
	(gets-mixed ?i - ingredient)  ; ingredient ?i gets mixed
	(shredded ?i - ingredient)  ; ingredient ?i is shredded
	(gets-shredded ?i - ingredient)  ; ingredient ?i gets shredded
	(sliced ?i - ingredient)  ; ingredient ?i is sliced
	(gets-sliced ?i - ingredient)  ; ingredient ?i gets shredded
	(cooked ?m - meal) ; meal ?m has been cooked
	(gets-cooked ?m - meal)  ; meal ?m gets cooked
	(assembled ?m - meal) ; meal ?m has been assembled
	(gets-assembled ?m - meal)  ; meal ?m gets assembled
    (is-cheeseburger ?m - meal)  ; meal is a cheeseburger
    (is-pizza ?m - meal)  ; meal is a pizza
    (is-salad ?m - meal)  ; meal is a salad
    (is-stew ?m - meal)  ; meal is stew
    (is-chili ?m - meal)  ; meal is chili
  )

  (:action prep-ingredient
    ; prepare an ingredient that needs to be prepped (a generic description if nothing else applies)
    :parameters (?i - ingredient ?l - inventory)
    :precondition (and
	  (on-hand ?i ?l)
	  (gets-prepped ?i)
	  (not (prepped ?i))
	  )
	:effect (and 
	  (prepped ?i)
	  (not (on-hand ?i ?l))
	  )
  )
  
  (:action shred-ingredient
    ; prepare an ingredient that needs to be shredded
    :parameters (?i - ingredient ?l - inventory)
    :precondition (and
	  (on-hand ?i ?l)
	  (gets-shredded ?i)
	  (not (shredded ?i))
	  )
	:effect (and
	  (shredded ?i)
	  (not (on-hand ?i ?l))
	  )
  )
  
  (:action mix-ingredient
    ; prepare an ingredient that needs to be mixed
    :parameters (?i - ingredient ?l - inventory)
    :precondition (and
	  (on-hand ?i ?l)
	  (gets-mixed ?i)
	  (not (mixed ?i))
	  )
	:effect (and
	  (mixed ?i)
	  (not (on-hand ?i ?l))
	  )
  )
  
  (:action slice-ingredient
    ; prepare an ingredient that needs to be sliced
    :parameters (?i - ingredient ?l - inventory)
    :precondition (and
	  (on-hand ?i ?l)
	  (gets-sliced ?i)
	  (not (sliced ?i))
	  )
	:effect (and
	  (sliced ?i)
	  (not (on-hand ?i ?l))
	  )
  )
  
  (:action meal-is-to-be-cooked
    ; prepare a meal that needs to be cooked (all cooked meals should be included in this action)
    :parameters (?m - meal)
    :precondition (and
	  (or
	    (is-pizza ?m)
		(is-cheeseburger ?m)
		(is-stew ?m)
		(is-chili ?m)
		)
	  (not (gets-cooked ?m))
	  )
	:effect (gets-cooked ?m)
  )
  
  (:action meal-is-to-be-assembled
    ; prepare a meal that needs to be assembled without being cooked
    :parameters (?m - meal)
    :precondition (and
	  (or
	    (is-salad ?m)
		)
	  (not (gets-assembled ?m))
	  )
	:effect (gets-assembled ?m)
  )
  
  (:action cook-pizza
    ; prepare a cheese pizza
    :parameters (?m - meal ?c - chef ?p - pan ?o - oven)
    :precondition (and
      (is-pizza ?m)
	  (scheduled ?c)
	  (can-cook ?c ?m)
	  (available-pizza-pan ?p)
	  (available-oven ?o)
	  (prepped dough)
	  (mixed sauce)
	  (shredded cheese)
	  (gets-cooked ?m)
	  (not (cooked ?m))
	)
	:effect (and
      (cooked ?m)
	  (not (prepped dough))
	  (not (mixed sauce))
	  (not (shredded cheese))
	)
  )
  
  (:action cook-burger
    ; prepare a cheeseburger
    :parameters (?m - meal ?c - chef ?g - grill)
    :precondition (and
      (is-cheeseburger ?m)
	  (scheduled ?c)
	  (can-cook ?c ?m)
	  (available-grill ?g)
	  (sliced bun)
	  (sliced tomato)
	  (sliced cheese)
	  (prepped ground-beef)
	  (gets-cooked ?m)
	  (not (cooked ?m))
	)
	:effect (and
      (cooked ?m)
	  (not (sliced bun))
	  (not (prepped ground-beef))
	  (not (sliced cheese))
	  (not (sliced tomato))
	)
  )

  (:action make-salad
    ; prepare a salad
    :parameters (?m - meal ?c - chef)
    :precondition (and
      (is-salad ?m)	
	  (scheduled ?c)
	  (can-cook ?c ?m)
	  (prepped lettuce)
	  (sliced tomato)
	  (sliced onion)
	  (sliced carrot)
	  (gets-assembled ?m)
	  (not (assembled ?m))
	)
	:effect (and
      (assembled ?m)
	  (not (prepped lettuce))
	  (not (sliced tomato))
	  (not (sliced onion))
	  (not (sliced carrot))
	)
  )

  (:action make-stew
    ; prepare a beef stew
    :parameters (?m - meal ?c - chef ?s - stove ?p - pot)
    :precondition (and
      (is-stew ?m)	
	  (scheduled ?c)
	  (can-cook ?c ?m)
	  (available-stove ?s)
	  (available-pot ?p)
	  (prepped ground-beef)
	  (mixed sauce)
	  (prepped beans)
	  (gets-cooked ?m)
	  (not (cooked ?m))
	)
	:effect (and
      (cooked ?m)
	  (not (prepped ground-beef))
	  (not (mixed sauce))
	  (not (prepped beans))
	)
  )

  (:action make-chili
    ; prepare a beef chili (basically, stew plus tomato)
    :parameters (?m - meal ?c - chef ?s - stove ?p - pot)
    :precondition (and
      (is-chili ?m)	
	  (scheduled ?c)
	  (can-cook ?c ?m)
	  (available-stove ?s)
	  (available-pot ?p)
	  (prepped ground-beef)
	  (mixed sauce)
	  (prepped beans)
	  (prepped tomato)
	  (gets-cooked ?m)
	  (not (cooked ?m))
	)
	:effect (and
      (cooked ?m)
	  (not (prepped ground-beef))
	  (not (mixed sauce))
	  (not (prepped beans))
	  (not (prepped tomato))
	)
  )

  (:action serve-cooked-meal
    ; serve a cooked meal - this action sets the goal
    :parameters (?m - meal)
    :precondition (and
	  (cooked ?m)
	  (not (prepared ?m))
	  )
	:effect (prepared ?m)
  )

  (:action serve-assembled-meal
    ; serve an assembled meal - this action sets the goal
    :parameters (?m - meal)
    :precondition (and
	  (assembled ?m)
	  (not (prepared ?m))
	  )
	:effect (prepared ?m)
  )
  
  
)