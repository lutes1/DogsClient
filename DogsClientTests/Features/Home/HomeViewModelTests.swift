//
//  HomeViewModelTests.swift
//  DogsClientTests
//
//  Created by Petru Lutenco on 14.09.2022.
//

import XCTest
import Combine

@testable import DogsClient

final class HomeViewModelTests: XCTestCase {
  private var homeViewModel: HomeViewModel!
  private var apiMock: ApiProtocol!
  
  override func setUp() {
    apiMock = ApiMock()
    homeViewModel = HomeViewModel(apiService: apiMock)
  }
  
  func testHomeViewModelLoading() async throws {
    // Act
    try await homeViewModel.load()
    
    // Assert
    XCTAssert(homeViewModel.breeds.count == 4)
    XCTAssert(homeViewModel.breeds == [Breed(name: "hound", subBreeds: ["dog"]),
                                       Breed(name: "hound2", subBreeds: ["dog", "dog2"])])
  }
}

fileprivate extension HomeViewModelTests {
  class ApiMock: ApiProtocol {
    convenience init() {
      let networkProviderMock = mock(NetworkProviderProtocol.self)
      self.init(networkProvider: networkProviderMock)
    }
    
    required init(networkProvider: NetworkProviderProtocol) {
    }
    
    func get<T>(endpoint: DogsClient.Endpoint) async throws -> T where T : Decodable {
      BreedsListWithSubbreedsModel(status: "", contents: ["hound": ["dog"], "hound2": ["dog", "dog2"]]) as! T
    }
    
    func get(endpoint: DogsClient.Endpoint) async throws -> Data {
      return Data()
    }
  }
}
