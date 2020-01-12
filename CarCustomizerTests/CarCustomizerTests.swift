//
//  CarCustomizerTests.swift
//  CarCustomizerTests
//
//  Created by Anish Kochhar on 12/01/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import XCTest
@testable import CarCustomizer

class CarCustomizerTests: XCTestCase {

    func testDisplayStatsReturnsMultilineStringWithValues() {
        
        let makes = ["Honda", "Tesla", "BMW", "Bentley"]
        let models = ["Civic", "Model X", "i8", "Continental GT"]
        let topSpeeds = [120, 180, 220, 155]
        let accelerations = [8.3, 5.1, 5.7, 7.1]
        let handlings = [4, 8, 7, 6]
        
        for i in 0..<4 {
            let car  = Car(make: makes[i], model: models[i], topSpeed: topSpeeds[i], acceleration: accelerations[i], handling: handlings[i])
            let carStats = car.displayStats()
            let expectedStats = """
            Make: \(makes[i])
            Model: \(models[i])
            Top Speed: \(topSpeeds[i]) mph
            Acceleration (0-60): \(accelerations[i])s
            Handling: \(handlings[i])
            """
            XCTAssertEqual(carStats, expectedStats)
        }
        //arrange
        let car = Car(make: "Mercedes Benz", model: "C-Class", topSpeed: 167, acceleration: 6.1, handling: 7)
        let expectedStats = """
        Make: Mercedes Benz
        Model: C-Class
        Top Speed: 167 mph
        Acceleration (0-60): 6.1s
        Handling: 7
        """
        //act
        let carStats = car.displayStats()
        //assert
        XCTAssertEqual(carStats, expectedStats)
        
    }

}
