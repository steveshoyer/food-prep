; Problem definition for food preparation project
; MET CS 644
; Steve Shoyer
; April 30, 2020
;
; Capitalized text will be replaced with order-specific text by the python program

(define (problem order-7)
  (:domain food-prep-7)
  (:objects
    inv - inventory  ; this is the inventory list
    grill1 - grill  ; a grill object
	stove1 - stove  ; a stove object
	pan1 - pan  ; a pan object
	pot1 pot2 pot3 - pot  ; pot objects
	oven1 - oven  ; an oven object
    chef1 chef2 - chef  ; two chef objects, with various skills
    INVENTORY-LIST - ingredient  ; list of available ingredients
    pizza salad cheeseburger stew chili - meal  ; different meals that can be prepared
  )
  (:init
    ; first, describe the ingredients and meals
	PROCESS-LIST
	(is-COOK-ME COOK-ME)
	; next, update the ingredients in the inventory
    ON-HAND-LIST
	(available-stove stove1)  ; there's a stove available
	(available-grill grill1)  ; there's a grill available
	(available-oven oven1)  ; there's an oven available
	(available-pizza-pan pan1)  ; there's a pizza pan available
	(available-pot pot3)  ; pot 3 is the only one available
	(scheduled chef1)  ; a chef is on the schedule
	(scheduled chef2)  ; another chef is also on the schedule
	(can-cook chef1 pizza)  ; chef 1 can cook a pizza
	(can-cook chef1 salad)  ; chef 1 can put together a salad
	(can-cook chef2 salad)  ; chef 2 can also put together a salad
	(can-cook chef2 stew)  ; chef 2 can cook stew
	(can-cook chef1 cheeseburger)  ; chef 1 can cook a burger
	(can-cook chef2 chili)  ; chef 2 can cook chili
  )
  ; set the goal to cook a meal
  (:goal
    (and 
      (prepared COOK-ME)
    ) 
  )
)