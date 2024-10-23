(define (problem windfarm-mission-1)
    (:domain windfarm)

    (:objects
        u - uuv ; the UUV
        s - ship ; the ship
        wp1 wp2 wp3 wp4 - location ; the 4 waypoints
        img - image ; the image that's going to be taken at wp3
        scan - sonar-scan ; the scan that's going to be taken at wp4
    )

    (:init
        ; State connections between waypoints
        ; If waypoints are connected both ways, both connections are added. Otherwise only one is
        (connected wp1 wp2)
        (connected wp2 wp1)
        (connected wp2 wp3)
        (connected wp3 wp4)
        (connected wp4 wp3)
        (connected wp4 wp1)

        ; State UUV status
        (not (deployed u)) ; the UUV can be deployed
        (at-ship u s) ; the UUV is at the ship

        ; State UUV storage status
        (not (memory-full u))
    )

    (:goal
        (and
            (captured-image img wp3) ; UUV captured an image at wp3
            (performed-scan scan wp4) ; UUV performed a scan at wp4
            (not (memory-full u)) ; Means the UUV saved everything it captured
        )
    )
)