(define (problem windfarm-mission-4)
    (:domain windfarm-1)

    (:objects
        u1 u2 - uuv
        s1 s2 - ship
        wp1 wp2 wp3 wp4 wp5 wp6 - location
        smpwp5 smpwp1 - sample
        imgwp3 imgwp2 - image
        scanwp4 scanwp6 - sonar-scan

        e1 e2 - engineer ; NEW
    )

    (:init
        (engineer-at-control-centre e1 s1) ; NEW
        (not (engineer-at-bay e1 s1)) ; NEW
        (engineer-at-control-centre e2 s2) ; NEW
        (not (engineer-at-bay e2 s2)) ; NEW

        (connected wp1 wp2)
        (connected wp2 wp1)
        (connected wp2 wp3)
        (connected wp2 wp4)
        (connected wp3 wp5)
        (connected wp4 wp2)
        (connected wp5 wp3)
        (connected wp5 wp6)
        (connected wp6 wp4)

        (deployed u1)
        (at u1 wp2)
        (not (at-ship u1 s1))
        (not (at-ship u1 s2))
        (not (deployed u2))
        (at-ship u2 s2)
        (not (at-ship u2 s1))

        (not (ship-full s1))
        (not (ship-full s2))

        (not (memory-full u1))
        (not (has-sample u1))
        (not (memory-full u2))
        (not (has-sample u2))
    )

    (:goal
        (and
            (captured-image imgwp3 wp3)
            (performed-scan scanwp4 wp4)
            (captured-image imgwp2 wp2)
            (performed-scan scanwp6 wp6)
            (collected-sample smpwp5 wp5)
            (collected-sample smpwp1 wp1)
            
            (not (memory-full u1))
            (not (memory-full u2))
            (not (uuv-full u1))
            (not (uuv-full u2))
        )
    )
)