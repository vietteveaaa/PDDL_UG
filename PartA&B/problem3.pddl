(define (problem windfarm-mission-3)
    (:domain windfarm)

    (:objects
        u1 u2 - uuv ; the 2 UUVs
        s1 s2 - ship ; the 2 ships
        wp1 wp2 wp3 wp4 wp5 wp6 - location ; the 6 waypoints
        smpwp5 smpwp1 - sample ; the samples that are going to be collected at wp1 and wp5
        imgwp3 imgwp2 - image ; the images that are going to be taken at wp2 and wp3
        scanwp4 scanwp6 - sonar-scan ; the scans that are going to be taken at wp4 and wp6
    )

    (:init
        ; State connections between waypoints
        ; If waypoints are connected both ways, both connections are added. Otherwise only one is
        (connected wp1 wp2)
        (connected wp2 wp1)
        (connected wp2 wp3)
        (connected wp2 wp4)
        (connected wp3 wp5)
        (connected wp4 wp2)
        (connected wp5 wp3)
        (connected wp5 wp6)
        (connected wp6 wp4)

        ; State UUV status
        (deployed u1) ; UUV 1 is deployed
        (at u1 wp2) ; and is at waypoint 2
        (not (at-ship u1 s1)) ; it's not at either of the ships
        (not (at-ship u1 s2))

        (not (deployed u2)) ; UUV 2 is not deployed
        (at-ship u2 s2) ; it's at ship 2
        (not (at-ship u2 s1)) ; and not at ship 1

        ; State a ship storage status - both empty
        (not (ship-full s1))
        (not (ship-full s2))

        ; State UUV storage status - both empty as well
        (not (memory-full u1))
        (not (has-sample u1))
        (not (memory-full u2))
        (not (has-sample u2))
    )

    (:goal
        (and
            ; Data and samples managed similarly to problem 1
            (captured-image imgwp3 wp3) ; one of the UUVs captured an image at wp3
            (performed-scan scanwp4 wp4) ; one of the UUVs performed a scan at wp4
            (captured-image imgwp2 wp2) ; one of the UUVs captured an image at wp2
            (performed-scan scanwp6 wp6) ; one of the UUVs performed a scan at wp6
            (collected-sample smpwp5 wp5) ; one of the UUVs collected a sample at wp5
            (collected-sample smpwp1 wp1) ; one of the UUVs collected a sample at wp5
            
            (not (memory-full u1)) ; Means the UUV1 stored any data it collected on a ship
            (not (memory-full u2)) ; Means the UUV2 stored any data it collected on a ship
            (not (uuv-full u1)) ; Means the UUV1 stored any sample it collected on a ship
            (not (uuv-full u2)) ; Means the UUV2 stored any sample it collected on a ship
        )
    )
)