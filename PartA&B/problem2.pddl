(define (problem windfarm-mission-2)
    (:domain windfarm)

    (:objects
        u - uuv
        s - ship
        wp1 wp2 wp3 wp4 wp5 - location
        smp - sample
        img - image
        scan - sonar-scan
    )

    (:init
        ; State connections between waypoints
        (connected wp1 wp2)
        (connected wp1 wp4)
        (connected wp2 wp3)
        (connected wp3 wp5)
        (connected wp4 wp3)
        (connected wp5 wp1)

        ; State UUV status
        (not (deployed u))
        (at-ship u s)

        ; State a ship storage status
        (not (ship-full s))

        ; State UUV storage status
        (not (memory-full u))
        (not (has-sample u))
    )

    (:goal
        (and
            ; Data managed similarly to problem 1
            (captured-image img wp5)
            (performed-scan scan wp3)
            (not (memory-full u))

            (collected-sample smp wp1) ; UUV collected a sample at wp1
            (not (uuv-full u)) ; Means the UUV stored a sample on a ship
        )
    )
)