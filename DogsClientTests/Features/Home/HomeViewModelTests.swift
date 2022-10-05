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
    let expectation = expectation(description: "viewModelLoading")
    homeViewModel.load()
    
    try await Task.sleep(nanoseconds: 5 * 1_000_000)
    
    expectation.fulfill()
    
    await self.waitForExpectations(timeout: 0)
    
    // Assert
    XCTAssert(homeViewModel.breeds.count == 2)
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
    
    func get(endpoint: DogsClient.Endpoint) -> AnyPublisher<Data, URLError> {
      Future { promise in
        promise(Result.success((try? JSONEncoder().encode(BreedsListWithSubbreedsModel(status: "", contents: ["hound": ["dog"], "hound2": ["dog", "dog2"]])))!))
      }
      .eraseToAnyPublisher()
    }
    
    func get(endpoint: DogsClient.Endpoint) async throws -> Data {
      return Data()
    }
  }
}
