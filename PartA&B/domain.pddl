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
                ; UUV status 
        (at-ship ?u - uuv ?s - ship)
        (deployed ?u - uuv)
        (at ?u - uuv ?loc - location)
        ; Are locations connected?
        (connected ?loc1 - location ?loc2 - location)
        ; Data management
        (captured-image ?img - image ?loc - location)
        (performed-scan ?scan - sonar-scan ?loc - location)
        (has-image ?u - uuv ?img - image)
        (has-scan ?u - uuv ?scan - sonar-scan)
        (memory-full ?u - uuv)
        (sent-image ?u - uuv ?img - image ?s - ship)
        (sent-scan ?u - uuv ?scan - sonar-scan ?s - ship)
        ; Sample management
        (collected-sample ?smp - sample ?loc - location)
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

    ; Deployment of UUV. UUV becomes deployed, lives a ship and gets to an underwhater location.
    (:action deploy-uuv
        :parameters (?u - uuv ?s - ship ?loc - location)
        :precondition (and ; the UUV's not deployed, is at the ship and not underwater
            (not (deployed ?u))
            (at-ship ?u ?s)
            (not (at ?u ?loc))
        )
        :effect (and ; the UUV is now deployed, it left the ship and moved to an underwater location
            (deployed ?u)
            (not (at-ship ?u ?s))
            (at ?u ?loc)
        )
    )

    ; Move UUV from one underwater waypoint to another one connected to the first one.
    (:action move-uuv
        :parameters (?u - uuv ?loc1 - location ?loc2 - location)
        :precondition (and ; the UUV is at a start location and it's connected to the end location
            (at ?u ?loc1)
            (not (at ?u ?loc2))
            (connected ?loc1 ?loc2)
        )
        :effect (and ; the UUV moved to the end location
            (not (at ?u ?loc1))
            (at ?u ?loc2)
        )
    )

    ; UUV returns to the ship
    ; Note: the UUV stays 'deployed', as otherwise it will be able to leave the ship again, which is prohibited.
    (:action return-to-ship
        :parameters (?u - uuv ?loc - location ?s - ship)
        :precondition (and ; the UUV's at an underwater location and not on the ship
            (at ?u ?loc)
            (not (at-ship ?u ?s))
        )
        :effect (and ; the UUV left the underwater location and is back onboard
            (not (at ?u ?loc))
            (at-ship ?u ?s)
        )
    )
    
    ; Capture an image.
    ; 'captured-image' is a permanent state and indicates that an image was once captured at a given location.
    ; 'has-image' indicates that the UUV now stores an image.
    ; Memory of the UUV becomes full until it saves the image on a ship.
    (:action capture-image
        :parameters (?u - uuv ?img - image ?loc - location)
        :precondition (and ; UUV's memory is empty and it's at the appropriate location
            (at ?u ?loc)
            (not (memory-full ?u))
        )
        :effect (and ; the UUV's memory is filled with an image and it remembers it captured an image at this wp
            (captured-image ?img ?loc)
            (has-image ?u ?img)
            (memory-full ?u)
        )
    )

    ; Perform a scan.
    ; 'performed-scan' is a permanent state and indicates that a scan was once performed at a given location.
    ; 'has-scan' indicates that the UUV now stores a scan.
    ; Memory of the UUV becomes full until it saves the scan on a ship.
    (:action perform-scan
        :parameters (?u - uuv ?scan - sonar-scan ?loc - location)
        :precondition (and ; UUV's memory is empty and it's at the appropriate location
            (at ?u ?loc)
            (not (memory-full ?u))
        )
        :effect (and ; the UUV's memory is filled with a scan and it remembers it performed a scan at this wp
            (performed-scan ?scan ?loc)
            (has-scan ?u ?scan)
            (memory-full ?u)
        )
    )

    ; Save an image on a ship.
    (:action send-image
        :parameters (?u - uuv ?img - image ?s - ship)
        :precondition (and ; the UUV's memory is filled with an image
            (has-image ?u ?img)
            (memory-full ?u)
        )
        :effect (and ; the UUV's memory is emptied and the image is sent to the ship
            (sent-image ?u ?img ?s)
            (not (has-image ?u ?img))
            (not (memory-full ?u))
        )
    )

    ; Save a scan on a ship
    (:action send-scan
        :parameters (?u - uuv ?scan - sonar-scan ?s - ship)
        :precondition (and ; the UUV's memory is filled with a scan
            (has-scan ?u ?scan)
            (memory-full ?u)
        )
        :effect (and ; the UUV's memory is emptied and the scan is sent to the ship
            (sent-scan ?u ?scan ?s)
            (not (has-scan ?u ?scan))
            (not (memory-full ?u))
        )
    )

    ; Collect a sample.
    ; 'collected-sample' is a permanent state and indicates that a sample was once collected at a given location.
    ; 'has-sample' indicates that the UUV now stores a sample.
    ; Storage of the UUV becomes full until it leaves the sample on a ship.
    (:action collect-sample 
        :parameters (?u - uuv ?smp - sample ?loc - location)
        :precondition (and ; UUV's storage is empty and it's at the appropriate location
            (at ?u ?loc)
            (not (uuv-full ?u))
        )
        :effect (and ; the UUV's storage is filled with a sample and it remembers it collected a sample at this wp
            (collected-sample ?smp ?loc)
            (has-sample ?u ?smp)
            (uuv-full ?u)
        )
    )

    ; Store a sample on a ship upon returning
    (:action store-sample
        :parameters (?u - uuv ?smp - sample ?s - ship)
        :precondition (and ; the UUV is at a ship, it has a sample and the ship's storage is empty
            (at-ship ?u ?s)
            (uuv-full ?u)
            (has-sample ?u ?smp)
            (not (ship-full ?s))
        )
        :effect (and ; the samples is transfered from the UUV to the ship's storage
            (not (uuv-full ?u))
            (not (has-sample ?u ?smp))
            (stored-sample ?u ?smp ?s)
            (ship-full ?s)
        )
    )
)