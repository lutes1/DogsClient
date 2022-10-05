//
//  ApiIntegrationTests.swift
//  DogsClientTests
//
//  Created by Petru Lutenco on 14.09.2022.
//

import XCTest
import Combine
@testable import DogsClient

final class ApiIntegrationTests: XCTestCase {
  private let apiClient = Api(networkProvider: URLSession.shared)
  private var cancellables: [AnyCancellable] = []
  
  func testBreedsEndpoint() {
    let expectation = self.expectation(description: "allBreedsEndpoint")
    var result: BreedsListModel!
    
    apiClient.get(endpoint: .allBreeds)
      .decode(type: BreedsListModel.self, decoder: JSONDecoder())
      .assertNoFailure()
      .sink { item in
        result = item
        expectation.fulfill()
      }
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 10)
    
    XCTAssert(result.status == "success")
    XCTAssert(result.contents.count > 0)
  }
  
  func testBreedsWithSubbreedsEndpoint() {
    var result: BreedsListWithSubbreedsModel!
    let expectation = self.expectation(description: "allBreedsWithSubbreedsEndpoint")
    
    apiClient.get(endpoint: .allBreedsWithSubbreeds)
      .decode(type: BreedsListWithSubbreedsModel.self, decoder: JSONDecoder())
      .assertNoFailure()
      .sink { item in
        result = item
        expectation.fulfill()
      }
      .store(in: &cancellables)
    
    waitForExpectations(timeout: 10)
    
    XCTAssert(result.status == "success")
    XCTAssert(result.contents.count > 0)
  }
}
