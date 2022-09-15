//
//  ApiTests.swift
//  DogsClientTests
//
//  Created by Petru Lutenco on 14.09.2022.
//

import XCTest
import Cuckoo

@testable
import DogsClient

final class ApiTests: XCTestCase {
  private var api: Api!
  private var networkProviderMock: MockNetworkProviderProtocol!
  
  override func setUp() {
    networkProviderMock = MockNetworkProviderProtocol()
    api = Api(networkProvider: networkProviderMock)
  }
  
  func test() async throws {
    // Arrange
    stub(networkProviderMock) { stub in
      stub.data(from: anyURL())
        .thenReturn((testJsonData.data(using: .utf8)!, .init()))
    }
    
    // Act
    let result: TestModel = try await api.get(endpoint: Endpoint.allBreeds)
    
    // Assert
    XCTAssert(result.prop1 == 0)
    XCTAssert(result.prop2 == "string")
    XCTAssert(result.prop3 == [1, 2, 3])
  }
  
  private let testJsonData =
"""
{
  "prop1": 0,
  "prop2": "string",
  "prop3": [1, 2, 3]
}
"""
  
  private struct TestModel: Decodable {
    let prop1: Int
    let prop2: String
    let prop3: [Int]
  }
}

fileprivate func anyURL() -> ParameterMatcher<URL> {
  ParameterMatcher { _ in
    true
  }
}
