//
//  DogsPhotosViewModelTests.swift
//  DogsClientTests
//
//  Created by Petru Lutenco on 29.09.2022.
//

import XCTest
import Combine
import Mockingbird
@testable import DogsClient

final class DogsPhotosViewModelTests: XCTestCase {
  private var viewModel: DogsPhotosViewModel!
  private var cancellables: [AnyCancellable] = []
  private var apiMock: ApiProtocolMock!
  override func setUp() {
    apiMock = mock(ApiProtocol.self)
    viewModel = DogsPhotosViewModel(breed: "", apiService: apiMock)
  }
  
  func testFailure() async throws {
    // Arrange
    given(apiMock.get(endpoint: .picturesOfBreed(any())))
      .willReturn(Future { promise in
        promise(Result.failure(URLError(URLError.badURL)))
      }
      .eraseToAnyPublisher()
    )
    
    // Act
    viewModel.load()
    
    try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
    
    // Assert
    XCTAssert(viewModel.images.isEmpty)
  }
  
  func testSuccess() async throws {
    // Arrange
    givenSwift(apiMock.get(endpoint: .picturesOfBreed(any(String.self))))
      .will { _ in
        Future { promise in
          let data = (try? JSONEncoder().encode(BreedsListModel(status: "success", contents: Array(repeating: "a", count: 200))))!
          promise(.success(data))
        }
        .eraseToAnyPublisher()
      }
    
    givenSwift(apiMock.get(endpoint: .picture(any(String.self))))
      .will { _ in
        Future<Data, URLError> { promise in
          let data = (UIImage(systemName: "circle")?.pngData())!
          promise(.success(data))
        }
        .eraseToAnyPublisher()
      }
    
    // Act
    viewModel.load()
    
    try await Task.sleep(nanoseconds: nanosecondsFrom(seconds: 5))
    
    //Assert
    
    XCTAssert(!viewModel.images.isEmpty)
    XCTAssert(viewModel.images.count == 200)
  }

  func testexample() {
    givenSwift(apiMock.get(endpoint: .allBreeds))
      .will { _ in
        Future<Data, URLError> { o in
          o(.success(("suceess".data(using: .utf8)!)))
        }
        .eraseToAnyPublisher()
      }
    
    apiMock.get(endpoint: .allBreeds)
      .assertNoFailure()
      .sink { result in
        print(String(data: result, encoding: .utf8))
      }
      .store(in: &self.cancellables)
  }
  
  func testMockingbird() async throws {
    let api: ApiProtocolMock = mock(ApiProtocol.self)
    let model = Model(api: api)
    
    givenSwift(api.get(endpoint: .allBreeds))
      .will { a in
        Future<Data, URLError> { promise in
          let data = (try? JSONEncoder().encode(BreedsListModel(status: "success", contents: Array(repeating: "a", count: 200))))!
          promise(.success(data))
        }
        .eraseToAnyPublisher()
      }
    
    
    model.fetch()
    
    try await Task.sleep(nanoseconds: nanosecondsFrom(seconds: 5))
    
    XCTAssert(model.breedListModel?.status != "error")
    XCTAssert(model.breedListModel?.status == "success")
    XCTAssert(!(model.breedListModel?.contents.isEmpty ?? true))
    XCTAssert(model.breedListModel?.contents.count == 200)
  }
}

class Model {
  var cancellables: [AnyCancellable] = []
  internal init(api: ApiProtocol) {
    self.api = api
  }
  
  var breedListModel: BreedsListModel? = nil
  
  private let api: ApiProtocol
  
  func fetch() {
    api.get(endpoint: .allBreeds)
      .decode(type: BreedsListModel.self, decoder: JSONDecoder())
      .catch { error in
        print(error)
        return Just(BreedsListModel(status: "error", contents: []))
      }
      .sink { result in
        self.breedListModel = result
      }
      .store(in: &cancellables)
  }
}

extension XCTest {
  func nanosecondsFrom(seconds: Int) -> UInt64 {
    UInt64(seconds) * 1_000_000_000
  }
}
