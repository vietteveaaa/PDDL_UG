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
        (connected wp1 wp2)
        (connected wp1 wp4)
        (connected wp2 wp3)
        (connected wp3 wp5)
        (connected wp4 wp3)
        (connected wp5 wp1)

        (not (deployed u))
        (at-ship u s)

        (not (ship-full s))
        (not (memory-full u))
        (not (has-sample u))
    )

    (:goal
        (and
            (captured-image img wp5)
            (performed-scan scan wp3)
            (collected-sample smp wp1)
            (not (memory-full u))
            (not (uuv-full u))
        )
    )
)