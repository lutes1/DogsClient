//
//  ApiTests.swift
//  DogsClientTests
//
//  Created by Petru Lutenco on 14.09.2022.
//

import XCTest
import Combine
@testable
import DogsClient

final class ApiTests: XCTestCase {
  private var api: Api!
  private var networkProviderMock: NetworkProviderProtocol!
  private var cancellables: [AnyCancellable] = []
  
  override func setUp() {
    networkProviderMock = NetworkProviderMock()
    api = Api(networkProvider: networkProviderMock)
  }
  
  func testDataIntegrity() {
    // Act
    var result: TestModel!
    
    let expectation = self.expectation(description: "allBreedsEndpoint")
    
    api.get(endpoint: Endpoint.allBreeds)
      .decode(type: TestModel.self, decoder: JSONDecoder())
      .assertNoFailure()
      .sink { input in
        result = input
        expectation.fulfill()
      }
      .store(in: &cancellables)
    
    self.waitForExpectations(timeout: 10)
    
    // Assert
    XCTAssert(result.prop1 == 0)
    XCTAssert(result.prop2 == "string")
    XCTAssert(result.prop3 == [1, 2, 3])
  }
}

fileprivate extension ApiTests {
  class NetworkProviderMock: NetworkProviderProtocol {
    func dataPublisher(for: URL) ->  AnyPublisher<Data, URLError> {
      Future { promise in
        promise(Result.success(Self.testJsonData.data(using: .utf8)!))
      }
          .eraseToAnyPublisher()
    }
    
    private static let testJsonData =
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

