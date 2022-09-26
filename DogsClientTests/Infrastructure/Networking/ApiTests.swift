//
//  ApiTests.swift
//  DogsClientTests
//
//  Created by Petru Lutenco on 14.09.2022.
//

import XCTest

@testable
import DogsClient

final class ApiTests: XCTestCase {
  private var api: Api!
  private var networkProviderMock: NetworkProviderProtocol!
  
  override func setUp() {
    networkProviderMock = NetworkProviderMock()
    api = Api(networkProvider: networkProviderMock)
  }
  
  func test() async throws {
    // Act
    let result: TestModel = try await api.get(endpoint: Endpoint.allBreeds)
    
    // Assert
    XCTAssert(result.prop1 == 0)
    XCTAssert(result.prop2 == "string")
    XCTAssert(result.prop3 == [1, 2, 3])
  }

}

fileprivate extension ApiTests {
  class NetworkProviderMock: NetworkProviderProtocol {
    func data(from: URL) async throws -> (Data, URLResponse) {
      (testJsonData.data(using: .utf8)!, .init())
    }
    
    private let testJsonData =
      """
      {
        "prop1": 0,
        "prop2": "string",
        "prop3": [1, 2, 3]
      }
      """
  }
  
  private struct TestModel: Decodable {
    let prop1: Int
    let prop2: String
    let prop3: [Int]
  }
}

