(define (domain mb_domain)

  (:requirements :typing :universal-preconditions :conditional-effects :equality)

  (:types
    holdable location monkey hand box tap - object
    glass banana knife - holdable    
  )

  (:predicates
    (at ?obj - object ?loc - location)
    (has ?monkey - monkey ?hand - hand)
    (holding ?hand - hand ?holdable - holdable) 	
    (high ?obj - object) ; The monkey is high when it climbs up the box
    (edge ?loc - location) ; Denotes if the location is at the edge of the room
    (full ?glass - glass)
  ) 

  (:action go
    :parameters (?monkey - monkey ?from ?to - location)
    :precondition 
    (and
      (at ?monkey ?from)
      (not(high ?monkey))
      )
    :effect (and(at ?monkey ?to) (not(at ?monkey ?from)))
    )

  (:action climb
    :parameters (?monkey - monkey)
    :precondition 
    (and 
      (exists(?loc - location) (and(at ?monkey ?loc) (at box ?loc)))
      (not(high ?monkey))
      )
    :effect (high ?monkey)
    )

  (:action get_down
  :parameters (?monkey - monkey)
  :precondition (high ?monkey)
  :effect (not(high ?monkey)))

  (:action push-box
    :parameters (?monkey - monkey ?hand1 ?hand2 - hand ?box - box ?from ?to - location)
    :precondition 
    (and 
      (at ?monkey ?from)
      (at ?box ?from)
      (has ?monkey ?hand1)
      (has ?monkey ?hand2)
      (not(= ?hand1 ?hand2))
      (not(high ?monkey))
      (forall(?h - holdable) (not(or (holding ?hand1 ?h) (holding ?hand2 ?h))))
      )
    :effect
    (and
      (not(at ?monkey ?from))
      (not(at ?box ?from))
      (at ?monkey ?to)
      (at ?box ?to))
    )

  (:action take_banana
    :parameters (?monkey - monkey ?take_hand ?knife_hand - hand ?banana - banana ?loc - location)
    :precondition 
    (and 
      (has ?monkey ?take_hand)
      (has ?monkey ?knife_hand)
      (not(= ?take_hand ?knife_hand))
      (holding ?knife_hand knife)
      (forall(?h - holdable) (not(holding ?take_hand ?h)))
      (or(and(high ?monkey) (high ?banana)) (and(not(high ?monkey)) (not(high ?banana)))) ; height of monkey == height of banana
      (at ?monkey ?loc)
      (at ?banana ?loc)      
      )
    :effect 
    (and 
      (not(at ?banana ?loc))
      (not(high ?banana))
      (holding ?take_hand ?banana)))

  (:action take_knife
    :parameters (?monkey - monkey ?take_hand - hand ?knife - knife ?loc - location)
    :precondition 
    (and 
      (has ?monkey ?take_hand)
      (forall(?h - holdable) (not(holding ?take_hand ?h)))
      (or(and(high ?monkey) (high ?knife)) (and(not(high ?monkey)) (not(high ?knife)))) ; height of monkey == height of knife
      (at ?monkey ?loc)
      (at ?knife ?loc)
      )
    :effect 
    (and 
      (not(at ?knife ?loc))
      (not(high ?knife))
      (holding ?take_hand ?knife)))

  (:action take_empty_glass
    :parameters (?monkey - monkey ?take_hand - hand ?glass - glass ?loc - location)
    :precondition 
    (and 
      (has ?monkey ?take_hand)
      (not(full ?glass))
      (forall(?h - holdable) (not(holding ?take_hand ?h)))
      (or(and(high ?monkey) (high ?glass)) (and(not(high ?monkey)) (not(high ?glass)))) ; height of monkey == height of glass
      (at ?monkey ?loc)
      (at ?glass ?loc)
      )
    :effect 
    (and 
      (not(high ?glass))
      (not(at ?glass ?loc))
      (holding ?take_hand ?glass)))

  (:action take_full_glass
    :parameters (?monkey - monkey ?hand1 ?hand2 - hand ?glass - glass ?loc - location)
    :precondition 
    (and
      (has ?monkey ?hand1)
      (has ?monkey ?hand2)
      (not(= ?hand1 ?hand2))
      (full ?glass)
      (at ?monkey ?loc)
      (at ?glass ?loc)
      (forall(?h - holdable) (not(or (holding ?hand1 ?h) (holding ?hand2 ?h))))
      (or(and(high ?monkey) (high ?glass)) (and(not(high ?monkey)) (not(high ?glass)))) ; height of monkey == height of glass
      )
    :effect 
    (and 
      (not(high ?glass))
      (not(at ?glass ?loc))
      (holding ?hand1 ?glass)
      (holding ?hand2 ?glass)
      ))

  (:action fill_glass
    :parameters (?monkey - monkey ?glass_hand ?other_hand - hand ?glass - glass ?loc - location)
    :precondition 
    (and 
      (has ?monkey ?glass_hand)
      (has ?monkey ?other_hand)
      (not(= ?glass_hand ?other_hand))
      (holding ?glass_hand ?glass)
      (not(full ?glass))
      (forall(?h - holdable) (not(holding ?other_hand ?h)))
      (or(and(high ?monkey) (high tap)) (and(not(high ?monkey)) (not(high tap)))) ; height of monkey == height of tap
      (at ?monkey ?loc)
      (at tap ?loc)
      ;(at ?tap ?loc)      
      )
    :effect 
    (and 
      (holding ?other_hand ?glass)
      (full ?glass)))

  (:action release_one_handed
    :parameters (?monkey - monkey ?holding_hand ?other_hand - hand ?holdable - holdable ?loc - location)
    :precondition 
    (and 
      (has ?monkey ?holding_hand)
      (has ?monkey ?other_hand)
      (not(= ?holding_hand ?other_hand))
      (holding ?holding_hand ?holdable)
      (not(holding ?other_hand ?holdable)) ; We check this to make sure nothing is being held that requires two hands (such as a full water glass)
      (at ?monkey ?loc)
      )
      
    :effect 
    (and 
      (not(holding ?holding_hand ?holdable))
      (at ?holdable ?loc)
      (when (high ?monkey) (high ?holdable))
      )
    )

  (:action release_two_handed
    :parameters (?monkey - monkey ?hand1 ?hand2 - hand ?holdable - holdable ?loc - location)
    :precondition 
    (and 
      (has ?monkey ?hand1)
      (has ?monkey ?hand2)
      (not(= ?hand1 ?hand2))
      (holding ?hand1 ?holdable)
      (holding ?hand2 ?holdable)
      (at ?monkey ?loc)
      )
    :effect 
    (and 
      (not(holding ?hand1 ?holdable))
      (not(holding ?hand2 ?holdable))
      (at ?holdable ?loc)
      (when(high ?monkey) (high ?holdable))
      )
    )
)
