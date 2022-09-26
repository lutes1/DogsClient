//
//  HomeViewTests.swift
//  DogsClientTests
//
//  Created by Petru Lutenco on 15.09.2022.
//

import XCTest
@testable import DogsClient
import ViewInspector
import SwiftUI

extension HomeView: Inspectable { }

final class HomeViewTests: XCTestCase {
  fileprivate var view: HomeView<HomeViewModelMock, HomeRouterMock>!
  
  override func setUp() {
    let viewModel = HomeViewModelMock()
    let router = HomeRouterMock()
    view = HomeView(viewModel: viewModel, router: router)
  }

  func testNavigatioLinkFont() throws {
    let isFontCallOut = try view.inspect().find(viewWithAccessibilityIdentifier: "navigationLinkLabel").text().attributes().font() == .callout
    XCTAssert(isFontCallOut)
  }
}

fileprivate extension HomeViewTests {
  class HomeViewModelMock: DogsClient.HomeViewModelProtocol {
    func loadPlainBreeds() async throws {
    }
    
    var breeds: [String] = ["1", "2", "3"]
    
    var navigationRoute: DogsClient.HomeNavigationRoute? = nil
  }
  
  class HomeRouterMock: DogsClient.HomeRouterProtocol {
    func destination(for route: HomeNavigationRoute?) -> EmptyView {
      EmptyView()
    }
  }
}
