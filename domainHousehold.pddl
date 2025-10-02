(define (domain household-tasks)

(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :negative-preconditions :duration-inequalities)

(:types
  
    bIngredient ; ingredients for breakfast
    lIngredient ; ingredients for Lunch
    dIngredient ; ingredients for dinner
    clothes     
    laundry-basket
    bUtensil    ; utensil for breakfast
    lUtensil    ; utensil for lunch
    dUtensil    ; utensil for dinner
    cleaner     ; for Vacuuming rooms
    location
    rooms      ; all rooms
    window     
    window-cleaner
    snacks
    sUtensil    
    plant
    watering-can 
    toilet
    tcleaner
    mcleaner
    bed
    table
    tacleaner
    ;starttime
    ;endtime 
)
 
(:predicates
    ;locations predicates
    (at-location-kit ?l - location)
    (at-location-laun ?l - location)
    (at-location-din ?l - location)
    (at-location-gar ?l - location) ; is it at this location
    (at-locationb ?l - location)
    (at-location-liv ?l - location)
    (at-locationw ?l - location)
    
    ;breakfast predicates
    (has-bIngredient ?bi - bIngredient ) ; is the ingredient for breakfast available
    (has-bUtensil ?ub - bUtensil) ; is utensil for breakfast available
    (fetch-breakfast-ingredient)
    (fetch-breakfast-utensil)
    (toasting)
    (make-breakfast)
    (serving-breakfast)
    (serve-breakfast)
    (set-table-breakfast)

    ;laundry predicates
    (has-laundry-basket) 
    (has-clothes ?c)
    (loading-laundry)
    (load-laundry)
    (has-washer)
    (washer-off)
    (washer-running)
    (start-washer)
    (has-dryer)
    (dryer-off)
    (dryer-running)
    (start-dryer)
    (has-ironbox)
    (ironing-clothes)
    (iron-clothes)
    (has-shelf)
    (stack-clothes)

    ;lunch predicates
    (has-lIngredient ?li - lIngredient)
    (has-lUtensil ?ul - lUtensil)
    (fetch-lunch-ingredient)
    (fetch-lunch-utensil)
    (making-lunch)
    (make-lunch)
    (serving-lunch)
    (serve-lunch)
    (set-table-lunch)

    ;cleaning predicates    
    (window-dusty ?w)
    (has-window-cleaner ?wc)
    (dust-windows)
    (vacuum-rooms)
    (needs-cleaning ?r)
    (no-person ?r)
    (available-cleaners ?v - cleaner)
    (needs-cleaning-dishes ?d) 
    (available-sponge ?sp)
    (clean-dishes)
    (needs-cleaningt ?t - toilet)
    (no-persont ?t - toilet)
    (clean-toilet)
    (available-cleanerst ?tc - tcleaner)
    (table-messy ?ta - table)
    (available-cleanersta  ?tac - tacleaner)
    (clean-table)

    ;snacks predicates
    (has-snacks ?s)
    (has-sUtensil ?us)
    (serving-snacks)
    (serve-snacks)

    ;dinner predicates
    (has-dIngredient ?di - dIngredient)
    (has-dUtensil ?ud - dUtensil)
    (fetch-dinner-ingredient)
    (fetch-dinner-utensil)
    (making-salad)
    (make-dinner)
    (serving-dinner)
    (serve-dinner)
    (set-table-dinner)

    ;gardening predicates
    (has-watering-can ?wac)
    (fetch-watering-can)
    (water-plants)
    (plant-needs-water ?p)
    (lawn-overgrown ?la - lawn)
    (available-mower ?m - mower)
    (mow-lawn)
    
    ;trash predicates
    (has-trash-bag)
    (take-out-trash)
    
    ;bed predicates
    (bed-untidy ?b - bed)
    (make-bed)
    
    ;pets predicates   
    (hungry-pet ?p - pet)
    (has-pet-food ?pf - petfood)
    (feed-pet)
    
    
   
    
    )
  ;Make-bed task
  (:durative-action make-bed
    :parameters (?b - bed ?l - location )
    :duration (= ?duration 7)
    :condition (and
      (at start (and
        (bed-untidy ?b)
        (at-locationb ?l)
      ))
    )
    :effect (and
      (at start (and
        (not (at-locationb ?l))
           
        ))
      (at end (and
        (at-locationb ?l)
        (make-bed)
        
      ))
    )
  )


  ;Breakfast tasks
  (:durative-action fetch-breakfast-ingredient
    :parameters (?bi - bIngredient ?l - location )
    :duration (= ?duration 3)
    :condition (and
      (at start (and
        
        (at-location-kit ?l)
      ))
    )
    :effect (and
      (at start (and
        (not (at-location-kit ?l))
        (not(has-bIngredient ?bi))   
        ))
      (at end (and
        (at-location-kit ?l)
        (has-bIngredient ?bi)
        (fetch-breakfast-ingredient)
      ))
    )
    
    )
  (:durative-action fetch-breakfast-utensil
    :parameters (?ub - bUtensil ?bi - bIngredient ?l - location)
    :duration (= ?duration 3)
    :condition (and
      (at start (and
      
        
        (at-location-kit ?l)
      ))
    )
    :effect (and
      (at start (and
        (not (at-location-kit ?l))
        
      ))
      (at end (and
        (at-location-kit ?l)
        (has-bUtensil ?ub)
        (fetch-breakfast-utensil)
      ))
    )
  )

  (:durative-action make-breakfast
    :parameters (?bi - bIngredient ?l - location ?ub - bUtensil)
    :duration (= ?duration 20)
    :condition (and
      (at start (and
        (at-location-kit ?l)
        (fetch-breakfast-ingredient)
        (fetch-breakfast-utensil)
      ))
    )
    :effect (and
      (at start (and
        (not (has-bIngredient ?bi))
        (toasting)
      ))
      (at end (and
        (at-location-kit ?l)
        (make-breakfast)
        (not (toasting))
      ))
    )
  )
   (:durative-action serve-breakfast
    :parameters (?l - location)
    :duration (= ?duration 15)
    :condition (and
      (at start (and
        
        (set-table-breakfast)
        (at-location-din ?l)
      ))
    )
    :effect (and
      (at start (and
        
        (serving-breakfast)
      ))
      (at end (and
        (not(at-location-din ?l))
        (serve-breakfast)
        (not (serving-breakfast))
      ))
    )
  )
   (:durative-action set-table-breakfast
     :parameters (?ta - table ?l - location)
     :duration (= ?duration 10)
     :condition (and 
         (at start (and 
           (at-location-din ?l)
           (clean-table)
           (make-breakfast)
           
         ))
      )
     :effect (and 
         (at start (and 
           (not(at-location-din ?l))
         ))
         (at end (and 
           (at-location-din ?l)
           (set-table-breakfast)
         )))
   )  

   
   ;Lunch tasks
   (:durative-action fetch-lunch-ingredient
    :parameters (?li - lIngredient ?l - location  )
    :duration (= ?duration 3)
    :condition (and
      (at start (and
        
        (at-location-kit ?l)
      ))
    )
    :effect (and
      (at start (and
        (not (at-location-kit ?l))
        (not(has-lIngredient ?li))   
        ))
      (at end (and
        (at-location-kit ?l)
        (has-lIngredient ?li)
        (fetch-lunch-ingredient)
      ))
    )
    
    )
   (:durative-action fetch-lunch-utensil
    :parameters (?ul - lUtensil ?li - lIngredient ?l - location)
    :duration (= ?duration 3)
    :condition (and
      (at start (and
        
        (at-location-kit ?l)
      ))
    )
    :effect (and
      (at start (and
        (not (at-location-kit ?l))
        
      ))
      (at end (and
        (at-location-kit ?l)
        (has-lUtensil ?ul)
        (fetch-lunch-utensil)
      ))
    )
  )

  (:durative-action make-lunch
    :parameters (?li - lIngredient ?l - location ?ul - lUtensil)
    :duration (= ?duration 42)
    :condition (and
      (at start (and
        (at-location-kit ?l)
        (fetch-lunch-ingredient)        
        (fetch-lunch-utensil)
      ))
    )
    :effect (and
      (at start (and
        (not (has-lIngredient ?li))
        (making-lunch)
      ))
      (at end (and
        (make-lunch)
        (at-location-kit ?l)
        (not (making-lunch))
      ))
    )
  )
  (:durative-action set-table-lunch
     :parameters (?ta - table ?l - location)
     :duration (= ?duration 12)
     :condition (and 
         (at start (and 
           (at-location-din ?l)
           (clean-table)
           (make-lunch)
           
         ))
      )
     :effect (and 
         (at start (and 
           (not(at-location-din ?l))
         ))
         (at end (and 
           (at-location-din ?l)
           (set-table-lunch)
         )))
   )  
  (:durative-action serve-lunch
    :parameters (?l - location)
    :duration (= ?duration 17)
    :condition (and
      (at start (and
        (at-location-din ?l)
        (set-table-lunch)
      ))
    )
    :effect (and
      (at start (and
        
        (serving-lunch)
      ))
      (at end (and
        (at-location-din ?l)
        (serve-lunch)
        (not (serving-lunch))
      ))
    )
  )

  
  ;Snacks task
    (:durative-action serve-snacks
    :parameters (?s - snacks ?us - sUtensil ?r - rooms)
    :duration (= ?duration 4)
    :condition (and
      (at start (and
        (has-snacks ?s)
        (has-sUtensil ?us)
        
      ))
    )
    :effect (and
      (at start (and
        (not(has-snacks ?s))
        (serving-snacks)
      ))
      (at end (and
        (serve-snacks)
        (not (serving-snacks))
      ))
    )
  )
    

  ;Dinner tasks
    (:durative-action fetch-dinner-ingredient
    :parameters (?di - dIngredient ?l - location  )
    :duration (= ?duration 3)
    :condition (and
      (at start (and              
        (at-location-kit ?l)
      ))
    )
    :effect (and
      (at start (and
        (not (at-location-kit ?l))
        (not(has-dIngredient ?di))   
        ))
      (at end (and
        (at-location-kit ?l)
        (has-dIngredient ?di)
        (fetch-dinner-ingredient)
      ))
    )
   )  
    
  (:durative-action fetch-dinner-utensil
    :parameters (?ud - dUtensil ?di - dIngredient ?l - location)
    :duration (= ?duration 3)
    :condition (and
      (at start (and       
        
        (at-location-kit ?l)
      ))
    )
    :effect (and
      (at start (and
        (not (at-location-kit ?l))
        
      ))
      (at end (and
        (at-location-kit ?l)
        (has-dUtensil ?ud)
        (fetch-dinner-utensil)
      ))
    )
  )

  (:durative-action make-dinner
    :parameters (?di - dIngredient ?ud - dUtensil)
    :duration (= ?duration 20)
    :condition (and
      (at start (and
        (fetch-dinner-ingredient)
        (fetch-dinner-utensil)
      ))
    )
    :effect (and
      (at start (and
        (not (has-dIngredient ?di))
        (making-salad)
      ))
      (at end (and
        (make-dinner)
        (not (making-salad))
      ))
    )
  )
    
   (:durative-action set-table-dinner
     :parameters (?ta - table ?l - location)
     :duration (= ?duration 12)
     :condition (and 
         (at start (and 
           (at-location-din ?l)
           (clean-table)
           (make-dinner)
           
         ))
      )
     :effect (and 
         (at start (and 
           (not(at-location-din ?l))
         ))
         (at end (and 
           (at-location-din ?l)
           (set-table-dinner)
         )))
   )  
  (:durative-action serve-dinner
    :parameters (?l - location)
    :duration (= ?duration 15)
    :condition (and
      (at start (and
        (set-table-dinner)        
        (at-location-din ?l)
      ))
    )
    :effect (and
      (at start (and
        
        (serving-dinner)
      ))
      (at end (and
        (at-location-din ?l)
        (serve-dinner)
        (not (serving-dinner))
      ))
    )
  )


  ;Laundry tasks
  (:durative-action load-laundry
    :parameters (?c - clothes ?l - location) 
    :duration (= ?duration 17)
    :condition (and
      (at start (and
        
        (at-location-laun ?l)
        
        (has-laundry-basket)
        (has-clothes ?c)
        
      ))
    )
    :effect (and
      (at start (and
        (not (has-laundry-basket))
        (not (has-clothes ?c))
        (loading-laundry)
      ))
      (at end (and
        (at-location-laun ?l)
        (not (loading-laundry))
        (load-laundry)
      ))
    )
  )
   
  (:durative-action start-washer
    :parameters (?l - location)
    :duration (= ?duration 2)
    :condition (and
      (at start (and
        (at-location-laun ?l)
        (has-washer)
        (washer-off)
        (load-laundry)  
      ))
    )
    :effect (and
      (at start (and
        (not (washer-off))
        (washer-running)
      ))
      (at end (and
        (not (washer-running))
        (washer-off)
        (start-washer)
      ))
    )
  )  
  (:durative-action start-dryer
    :parameters (?l - location)
    :duration (= ?duration 2)
    :condition (and
      (at start (and
        (at-location-laun ?l)
        (has-dryer)
        (dryer-off)
        (start-washer)
         
      ))
    )
    :effect (and
      (at start (and
        (not (dryer-off))
        (dryer-running)
      ))
      (at end (and
        (not (dryer-running))
        (dryer-off)
        (start-dryer)
      ))
    )
  )
  (:durative-action iron-clothes
    :parameters (?l - location)
    :duration (= ?duration 25)
    :condition (and
      (at start (and
        (at-location-laun ?l)
        
        (start-dryer)
        (has-ironbox)
        
           ))
    )
    :effect (and
      (at start (and
        (not (ironing-clothes))
        
      ))
      (at end (and
        (ironing-clothes)
        (iron-clothes)
      ))
    )
  )
   (:durative-action stack-clothes
     :parameters (?c - clothes ?l - location)
     :duration (= ?duration 12)
     :condition (and 
         (at start (and 
           (iron-clothes )
           (at-locationw ?l)
           (has-shelf)
         ))
      )
     :effect (and 
         (at start (and 
           (not(at-locationw ?l))
         ))
         (at end (and 
           (at-locationw ?l)
           (stack-clothes)
         )))
   )  
  
   
  ;Pets task
  (:durative-action feed-pet
     :parameters (?p - pet ?pf - petfood  ?l - location)
     :duration (= ?duration 6)
     :condition (and 
         (at start (and 
           (hungry-pet ?p)
           (has-pet-food ?pf)
           (at-location-liv ?l)
         ))
      )
     :effect (and 
         (at start (and 
           (not(at-location-liv ?l))
         ))
         (at end (and 
           (at-location-liv ?l)
           (feed-pet)
         )))
   )  

  
  ;Gardening tasks
  
   (:durative-action fetch-watering-can
    :parameters (?wac - watering-can ?l - location)
    :duration (= ?duration 6)
    :condition (and
      (at start (and
        
        (at-location-gar ?l)
      ))
    )
    :effect (and
      (at start (and
        (not (at-location-gar ?l))
        (not (has-watering-can ?wac))
      ))
      (at end (and
        (at-location-gar ?l)
        (has-watering-can ?wac)
        (fetch-watering-can)
      ))
    )
  )

  (:durative-action water-plants
    :parameters (?p - plant ?l - location ?wac - watering-can)
    :duration (= ?duration 22)
    :condition (and
      (at start (and
        (at-location-gar ?l)
        (fetch-watering-can)
        (has-watering-can ?wac)
      ))
    )
    :effect (and
      (at start (and
        
        (not (has-watering-can ?wac))
      ))
      (at end (and
        (at-location-gar ?l)
        (water-plants)
        (not (plant-needs-water ?p))
      ))
    )
  )
  (:durative-action mow-lawn
     :parameters (?la - lawn ?m - mower ?l - location)
     :duration (= ?duration 30)
     :condition (and 
         (at start (and 
           (lawn-overgrown ?la)
           (available-mower ?m)
           (at-location-gar ?l)
         ))
      )
     :effect (and 
         (at start (and 
           (not(available-mower ?m))
           (not(at-location-gar ?l))
         ))
         (at end (and 
           (at-location-gar ?l)
           (not(lawn-overgrown ?la))
           (mow-lawn)
         )))
   )  


  ;Cleaning tasks
     (:durative-action dust-windows
    :parameters (?w - window ?wc - window-cleaner ?p - plant)
    :duration (= ?duration 20)
    :condition (and
      (at start (and
        
        
        (has-window-cleaner ?wc)
        (window-dusty ?w)
      ))
    )
    :effect (and
      (at start (and
        (not (window-dusty ?w))
      ))
      (at end (and
        (not (window-dusty ?w))
        (dust-windows)
      ))
    )
  )
   (:durative-action vacuum-rooms
     :parameters (?r - rooms ?v - cleaner)
     :duration (= ?duration 25)
     :condition (and 
         (at start (and 
           (dust-windows)
           (no-person ?r)
           (needs-cleaning ?r)
           (available-cleaners ?v)
         ))
      )
     :effect (and 
         (at start (and 
           (not(available-cleaners ?v))
         ))
         (at end (and 
           (available-cleaners ?v)
           (vacuum-rooms )
         )))
   )
   (:durative-action clean-toilet
     :parameters (?t - toilet ?tc - tcleaner)
     :duration (= ?duration 10)
     :condition (and 
         (at start (and 
           
           (no-persont ?t)
           (needs-cleaningt ?t)
           (available-cleanerst ?tc)
         ))
      )
     :effect (and 
         (at start (and 
           (not(available-cleanerst ?tc))
         ))
         (at end (and 
           (available-cleanerst ?tc)
           (clean-toilet )
         )))
     
   )  
    (:durative-action clean-table
     :parameters (?ta - table ?tac - tacleaner)
     :duration (= ?duration 5)
     :condition (and 
         (at start (and 
           (table-messy ?ta)           
           (available-cleanersta ?tac)
         ))
      )
     :effect (and 
         (at start (and 
           (not(available-cleanersta ?tac))
         ))
         (at end (and 
           (available-cleanersta ?tac)
           (clean-table )
         )))
   )  
   (:durative-action clean-dishes
     :parameters (?d - dishes ?l - location ?sp - sponge)
     :duration (= ?duration 30)
     :condition (and 
         (at start (and 
           (at-location-kit ?l)
           (needs-cleaning-dishes ?d)
           (available-sponge ?sp)
         ))
      )
     :effect (and 
         (at start (and 
           (not(available-sponge ?sp))
         ))
         (at end (and 
           (at-location-kit ?l)
           (available-sponge ?sp)
           (clean-dishes)
         )))
   ) 

   
   ;Take out trash task
  (:durative-action take-out-trash
    :parameters (?l - location)
    :duration (= ?duration 12)
    :condition (and
      (at start (and
      
        (at-location-kit ?l)
        (has-trash-bag)
      ))
    )
    :effect (and
      (at start (and
        (not (at-location-kit ?l))
        (not (has-trash-bag))
      ))
      (at end (and
        (at-location-kit ?l)
        (take-out-trash)
      ))
    )
  )
 

       
)