//
//  ApiIntegrationTests.swift
//  DogsClientTests
//
//  Created by Petru Lutenco on 14.09.2022.
//

import XCTest
@testable import DogsClient

final class ApiIntegrationTests: XCTestCase {
  private let apiClient = Api(networkProvider: URLSession.shared)
  
  func testBreedsEndpoint() async throws {
    let result: BreedsListModel = try await apiClient.get(endpoint: .allBreeds)
    XCTAssert(result.status == "success")
    XCTAssert(result.contents.count > 0)
  }
  
  func testBreedsWithSubbreedsEndpoint() async throws {
    let result: BreedsListWithSubbreedsModel = try await apiClient.get(endpoint: .allBreedsWithSubbreeds)
    XCTAssert(result.status == "success")
    XCTAssert(result.contents.count > 0)
  }
}
