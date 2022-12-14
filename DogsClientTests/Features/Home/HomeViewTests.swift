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
    func load() async throws {
    }
    
    var breeds: [Breed] = [
      Breed(name: "hound", subBreeds: ["dog"]),
      Breed(name: "hound2", subBreeds: ["dog", "dog2"])
    ]
    
    var navigationRoute: DogsClient.HomeNavigationRoute? = nil
  }
  
  class HomeRouterMock: DogsClient.HomeRouterProtocol {
    @Published var navigationRoute: HomeNavigationRoute?
    func destination() -> EmptyView {
      EmptyView()
    }
  }
}
