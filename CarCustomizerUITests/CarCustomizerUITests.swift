//
//  CarCustomizerUITests.swift
//  CarCustomizerUITests
//
//  Created by Anish Kochhar on 12/01/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import XCTest

class CarCustomizerUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenBoughtECUAndNitroPackagesOtherButtonsDisable() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        app.launch()
        
        //act
        app.switches["ECUSwitch"].tap()
        app.switches["NitroSwitch"].tap()
        
        //assert
        XCTAssertEqual(app.switches["TiresSwitch"].isEnabled, false)
        XCTAssertEqual(app.switches["ExhaustSwitch"].isEnabled, false)
    }
    
    func testThatECUSwitchReenablesWhenItBecomesAffordable() {
        
        let app = XCUIApplication()
        app.launch()
        
        //act
        app.switches["NitroSwitch"].tap()
        app.switches["TiresSwitch"].tap()
        app.switches["ExhaustSwitch"].tap()  // now all of these are enabled, so other switch is disabled
        
        XCTAssertEqual(app.switches["ECUSwitch"].isEnabled, false)
        
        app.switches["TiresSwitch"].tap()
        app.switches["ExhaustSwitch"].tap()   // funds are now 500
        
        //assert
        XCTAssertEqual(app.switches["ECUSwitch"].isEnabled, true)
        
    }
    
//    func testRemaingFundsResetsOnDisplayWhenNewCarIsChosen() {
//        let app = XCUIApplication()
//        app.launch()
//        //act
//        app.switches["NitroSwitch"].tap()
//        XCTAssertEqual(app.staticTexts[""].label, "Remaining Funds: 500")
//        app.buttons["NextCar"].tap()
//
//    }

}
