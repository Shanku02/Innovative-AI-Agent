
(define (problem household-tasks)

  (:domain household-tasks)

  (:objects
    kitchen laundryRoom diningRoom garden bedroom toilets wardrobe livingRoom - location
    toaster - bUtensil
    bread - bIngredient
    Dal - lIngredient
    Pan1 - lUtensil
    allClothes - clothes
    room - rooms
    vacuum - cleaner
    windows - window
    spray - window-cleaner
    cookies - snacks
    plate - sUtensil  
    salad - dIngredient
    bowl - dUtensil  
    dish - dishes
    spongee - sponge
    plants - plant
    wac - watering-can
    toilet - toilet
    toiletCleaner - tcleaner 
    mop - mcleaner
    beds - bed
    tables - table
    tableCleaner - tacleaner
    dog - pet
    pedigree - petfood
    grass - lawn
    lawnMower - mower
  )

  (:init
    (at-location-din diningRoom)
    (at-location-kit kitchen)
    (at-location-gar garden)
    (at-location-laun laundryRoom)
    (has-bIngredient bread)
    (has-bUtensil toaster)
    (has-lIngredient Dal)
    (has-lUtensil Pan1) 
    (has-laundry-basket)
    (has-clothes allClothes)
    (available-cleaners vacuum)
    (no-person room)
    (needs-cleaning room)
    (has-window-cleaner spray)
    (window-dusty windows)
    (has-snacks cookies)
    (has-sUtensil plate)
    (has-dIngredient salad)
    (has-dUtensil bowl)
    (needs-cleaning-dishes dish)
    (available-sponge spongee)
    (has-watering-can wac )
    (has-washer)
    (washer-off)
    (has-dryer)
    (dryer-off)
    (has-ironbox)
    (has-trash-bag)
    (available-cleanerst toiletCleaner)
    (no-persont toilet)
    (needs-cleaningt toilet)
    (at-locationb bedroom)
    (bed-untidy beds)
    (has-shelf)
    (at-locationw wardrobe)
    (table-messy tables)
    (available-cleanersta tableCleaner)
    (hungry-pet dog)
    (has-pet-food pedigree)
    (at-location-liv livingRoom)
    (lawn-overgrown grass)    
    (available-mower lawnMower)

        
  )   
    
  

(:goal (and
  (mow-lawn)
  (clean-toilet)
  (vacuum-rooms)  
  (Feed-pet)
  (Make-dinner)
  (Serve-dinner)
 (take-out-trash)
))
)
