//
//  HomeViewUITests.swift
//  DogsClientUITests
//
//  Created by Petru Lutenco on 15.09.2022.
//

import XCTest

final class AppFlowsTests: XCTestCase {
  var app: XCUIApplication!
  
  override func setUp() {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launchArguments = ["uitesting"]
    app.launch()
  }
  
  func testBasicAppFlow() throws {
    let navigationButton = self.app.buttons["navigationLink"].firstMatch
    XCTAssert(navigationButton.waitForExistence(timeout: 5))
    XCTAssert(navigationButton.isEnabled)
    XCTAssert(navigationButton.isHittable)
    // Tap on the first dog breed item in the list
    navigationButton.tap()
    
    let photoButton = self.app.buttons["photoButton"].firstMatch
    XCTAssert(photoButton.waitForExistence(timeout: 5))
    XCTAssert(photoButton.isEnabled)
    XCTAssert(photoButton.isHittable)
    
    // Tap on the first dog photo in the breed list
    photoButton.tap()
    
    let dogDetailImage = self.app.images["dogDetailImage"]
    XCTAssert(dogDetailImage.waitForExistence(timeout: 5))
    XCTAssert(dogDetailImage.isHittable)
    // Tap to zoom the picture in
    dogDetailImage.tap()
    
    // Tap to zoom the picture out
    dogDetailImage.tap()
    
    // Swipe down to dismiss the modal
    dogDetailImage.swipeDown(velocity: .fast)
    
    // Navigate back to the home screen
    let backButton = self.app.navigationBars.firstMatch.buttons.firstMatch
    XCTAssert(backButton.waitForExistence(timeout: 5))
    XCTAssert(backButton.isEnabled)
    XCTAssert(backButton.isHittable)
    backButton.tap()
    
    // Make sure we are back in the first page
    XCTAssert(navigationButton.waitForExistence(timeout: 5))
  }
}
