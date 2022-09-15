//
//  HomeViewModelTests.swift
//  DogsClientTests
//
//  Created by Petru Lutenco on 14.09.2022.
//

import XCTest
import Combine
import Cuckoo

@testable import DogsClient

final class HomeViewModelTests: XCTestCase {
  private var homeViewModel: HomeViewModel!
  private var apiMock: MockApiProtocol!
  
  override func setUp() {
    let networkProvider = MockNetworkProviderProtocol()
    apiMock = MockApiProtocol(networkProvider: networkProvider)
    homeViewModel = HomeViewModel(apiService: apiMock)
  }
  
  func testHomeViewModelLoading() async throws {
    // Arrange
    stub(apiMock) { api in
      api.get(endpoint: Endpoint.allBreeds).thenReturn(ApiModel(status: "", contents: ["a", "b", "c", "d"]))
    }
    
    // Act
    try await homeViewModel.loadPlainBreeds()
    
    // Assert
    XCTAssert(homeViewModel.breeds.count == 4)
    XCTAssert(homeViewModel.breeds == ["a", "b", "c", "d"])
  }
}

extension Endpoint: Matchable {
  public typealias MatchedType = Self
  
  public var matcher: Cuckoo.ParameterMatcher<MatchedType> {
    .init { tested in
      self == tested
    }
  }
}
