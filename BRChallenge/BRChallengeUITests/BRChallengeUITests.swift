//
//  BRChallengeUITests.swift
//  BRChallengeUITests
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import XCTest

class BRChallengeUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func testLunchTabTapped() {
        app.tabBars.buttons["Lunch"].tap()
        let lunchTymeNavigationBar = app.navigationBars["Lunch Tyme"]
        
        XCTAssert(lunchTymeNavigationBar.staticTexts["Lunch Tyme"].exists)
        XCTAssert(lunchTymeNavigationBar.children(matching: .button).element.exists)
    }
    
    func testInternetsTabTapped() {
        app.tabBars.buttons["Internets"].tap()
        let brchallengeInternetsviewNavigationBar = app.navigationBars["BRChallenge.InternetsView"]
        
        XCTAssert(brchallengeInternetsviewNavigationBar.exists)
        XCTAssert(brchallengeInternetsviewNavigationBar.buttons["ic webBack"].exists)
        XCTAssert(brchallengeInternetsviewNavigationBar.buttons["ic webRefresh"].exists)
        XCTAssert(brchallengeInternetsviewNavigationBar.buttons["ic webForward"].exists)
    }
    
    func testRestaurantDetails() {
        let cellgradientbackgroundElement = app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"cellGradientBackground").element
        cellgradientbackgroundElement.tap()
        let detailsNavigationBar = app.navigationBars["Details"]
        
        XCTAssert(detailsNavigationBar.exists)
        XCTAssert(detailsNavigationBar.buttons["icon map"].exists)
    }
    
    func testRestaurantDetailsBackButton() {
        app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"cellGradientBackground").children(matching: .other).element.children(matching: .other).element.tap()
        app.navigationBars["Details"].buttons["Lunch Tyme"].tap()
        
        XCTAssert(app.navigationBars["Lunch Tyme"].staticTexts["Lunch Tyme"].exists)
    }
}
