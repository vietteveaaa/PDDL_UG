(define (problem windfarm-mission-1)
    (:domain windfarm)

    (:objects
        u - uuv
        s - ship
        wp1 wp2 wp3 wp4 - location
        img - image
        scan - sonar-scan
    )

    (:init
        (connected wp1 wp2)
        (connected wp2 wp1)
        (connected wp2 wp3)
        (connected wp3 wp4)
        (connected wp4 wp3)
        (connected wp4 wp1)

        (not (deployed u))
        (at-ship u s)

        (not (memory-full u))
    )

    (:goal
        (and
            (captured-image img wp3)
            (performed-scan scan wp4)
            (not (memory-full u))
        )
    )
)