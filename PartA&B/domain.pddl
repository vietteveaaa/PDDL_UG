(define (domain windfarm)
    (:requirements :strips :typing)

    ; -------------------------------
    ; ---------- Task 1.1 -----------
    ; -------------------------------
    
    ; -------------------------------
    ; Types
    ; -------------------------------

    (:types
        uuv
        ship
        location
        sample
        image
        sonar-scan
    )

    ; -------------------------------
    ; Predicates
    ; -------------------------------

    (:predicates
        (at-ship ?u - uuv ?s - ship)
        (deployed ?u - uuv)
        (at ?u - uuv ?loc - location)
        (connected ?loc1 - location ?loc2 - location)
        (captured-image ?img - image ?loc - location)
        (performed-scan ?scan - sonar-scan ?loc - location)
        (has-image ?u - uuv ?img - image)
        (has-scan ?u - uuv ?scan - sonar-scan)
        (memory-full ?u - uuv)
        (sent-image ?u - uuv ?img - image ?s - ship)
        (sent-scan ?u - uuv ?scan - sonar-scan ?s - ship)
        (collected_sample ?smp - sample ?loc - location)
        (has-sample ?u - uuv ?smp - sample)
        (uuv-full ?u)
        (stored-sample ?u - uuv ?smp - sample ?s - ship)
        (ship-full ?s - ship)
    )

    ; -------------------------------
    ; ---------- Task 1.2 -----------
    ; -------------------------------

    ; -------------------------------
    ; Actions
    ; -------------------------------

    (:action deploy-uuv
        :parameters (?u - uuv ?s - ship ?loc - location)
        :precondition (and
            (not (deployed ?u))
            (at-ship ?u ?s)
            (not (at ?u ?loc))
        )
        :effect (and
            (deployed ?u)
            (not (at-ship ?u ?s))
            (at ?u ?loc)
        )
    )

    (:action move-uuv
        :parameters (?u - uuv ?loc1 - location ?loc2 - location)
        :precondition (and 
            (at ?u ?loc1)
            (not (at ?u ?loc2))
            (connected ?loc1 ?loc2)
        )
        :effect (and 
            (not (at ?u ?loc1))
            (at ?u ?loc2)
        )
    )

    (:action return-to-ship
        :parameters (?u - uuv ?loc - location ?s - ship)
        :precondition (and
            (at ?u ?loc)
            (not (at-ship ?u ?s))
        )
        :effect (and
            (not (at ?u ?loc))
            (at-ship ?u ?s)
        )
    )
    
    
    (:action capture-image
        :parameters (?u - uuv ?img - image ?loc - location)
        :precondition (and 
            (at ?u ?loc)
            (not (memory-full ?u))
        )
        :effect (and 
            (captured-image ?img ?loc)
            (has-image ?u ?img)
            (memory-full ?u)
        )
    )

    (:action perform-scan
        :parameters (?u - uuv ?scan - sonar-scan ?loc - location)
        :precondition (and 
            (at ?u ?loc)
            (not (memory-full ?u))
        )
        :effect (and 
            (performed-scan ?scan ?loc)
            (has-scan ?u ?scan)
            (memory-full ?u)
        )
    )

    (:action send-image
        :parameters (?u - uuv ?img - image ?s - ship)
        :precondition (and 
            (has-image ?u ?img)
            (memory-full ?u)
        )
        :effect (and 
            (sent-image ?u ?img ?s)
            (not (has-image ?u ?img))
            (not (memory-full ?u))
        )
    )

    (:action send-scan
        :parameters (?u - uuv ?scan - sonar-scan ?s - ship)
        :precondition (and 
            (has-scan ?u ?scan)
            (memory-full ?u)
        )
        :effect (and 
            (sent-scan ?u ?scan ?s)
            (not (has-scan ?u ?scan))
            (not (memory-full ?u))
        )
    )

    (:action collect-sample
        :parameters (?u - uuv ?smp - sample ?loc - location)
        :precondition (and 
            (at ?u ?loc)
            (not (uuv-full ?u))
        )
        :effect (and
            (collected_sample ?smp ?loc)
            (has-sample ?u ?smp)
            (uuv-full ?u)
        )
    )

    (:action store-sample
        :parameters (?u - uuv ?smp - sample ?s - ship)
        :precondition (and 
            (at-ship ?u ?s)
            (uuv-full ?u)
            (has-sample ?u ?smp)
            (not (ship-full ?s))
        )
        :effect (and 
            (not (uuv-full ?u))
            (not (has-sample ?u ?smp))
            (stored-sample ?u ?smp ?s)
            (ship-full ?s)
        )
    )
)