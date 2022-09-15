//
//  HomeViewUITests.swift
//  DogsClientUITests
//
//  Created by Petru Lutenco on 15.09.2022.
//

import XCTest

final class HomeViewUITests: XCTestCase {
  override func setUp() {
    continueAfterFailure = false
  }

  func testExample() throws {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    app.launch()
    
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
}
