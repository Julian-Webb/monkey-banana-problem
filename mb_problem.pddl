(define (problem mb_problem)
  (:domain mb_domain)
  (:objects
    P1 P2 P3 P4 P5 P6 - location
    monkey - monkey
    hand1 hand2 - hand
    banana - banana
    box - box
    knife - knife
    tap - tap
    glass - glass
  )

  (:init
    (at monkey P1)
    (at box P2)
    (at banana P3)
    (high banana)
    (at knife P4)
    (at tap P5)
    (at glass P5)
    (high glass)
    (high tap)
    (has monkey hand1)
    (has monkey hand2)
  )
  (:goal 
    (and
      (exists(?loc - location) 
        (and(at monkey ?loc) (at banana ?loc) 
          (or(and(high monkey) (high banana)) (and(not(high monkey)) (not(high banana)))) ; height of monkey == height of banana
          ))
      (exists(?loc - location) 
        (and(at monkey ?loc) (at glass ?loc) (full glass) 
          (or(and(high monkey) (high glass)) (and(not(high monkey)) (not(high glass)))) ; height of monkey == height of glass
          ))
      (or (at box P1) (at box P6))
      (or (at knife P1) (at knife P6))    
      ; The monkey isn't at the same postion as the box or the knife (The room is tidy)
      (forall(?loc - location) (not(and (at monkey ?loc) (or (at box ?loc) (at knife ?loc)))))
      
    )
  )
)