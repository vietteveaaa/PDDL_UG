(define (problem windfarm-mission-2)
    (:domain windfarm)

    (:objects
        u - uuv ; the UUV
        s - ship ; the ship
        wp1 wp2 wp3 wp4 wp5 - location ; the 5 waypoints
        smp - sample ; the sample that's going to be collected at wp1
        img - image ; the image that's going to be taken at wp5
        scan - sonar-scan ; the scan that's going to be taken at wp3
    )

    (:init
        ; State connections between waypoints
        ; If waypoints are connected both ways, both connections are added. Otherwise only one is
        (connected wp1 wp2)
        (connected wp1 wp4)
        (connected wp2 wp3)
        (connected wp3 wp5)
        (connected wp4 wp3)
        (connected wp5 wp1)

        ; State UUV status
        (not (deployed u)) ; the UUV can be deployed
        (at-ship u s) ; the UUV is at the ship

        ; State a ship storage status
        (not (ship-full s))

        ; State UUV storage status
        (not (memory-full u))
        (not (has-sample u))
    )

    (:goal
        (and
            ; Data managed similarly to problem 1
            (captured-image img wp5) ; UUV captured an image at wp5
            (performed-scan scan wp3) ; UUV performed a scan at wp3
            (not (memory-full u)) ; UUV saved the data it collected on the ship

            (collected-sample smp wp1) ; UUV collected a sample at wp1
            (not (uuv-full u)) ; Means the UUV stored a sample on a ship
        )
    )
)