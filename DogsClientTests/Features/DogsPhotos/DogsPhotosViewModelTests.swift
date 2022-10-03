//
//  DogsPhotosViewModelTests.swift
//  DogsClientTests
//
//  Created by Petru Lutenco on 29.09.2022.
//

import XCTest
import Mockingbird
@testable import DogsClient

final class DogsPhotosViewModelTests: XCTestCase {
  private var viewModel: DogsPhotosViewModel!
  
  override func setUp() {
    let api = ApiMock()
    let dispatcher = mock(DispatcherProtocol.self)
    given(dispatcher.main(any())).will { action in
      action()
    }
    
    viewModel = DogsPhotosViewModel(breed: "", apiService: api, dispatcher: dispatcher)
  }
}

fileprivate extension DogsPhotosViewModelTests {
  class ApiMock: ApiProtocol {
    
    convenience init() {
      self.init(networkProvider: URLSession.shared)
    }
    
    required init(networkProvider: NetworkProviderProtocol) {
    }
    
    func get<T>(endpoint: DogsClient.Endpoint) async throws -> T where T : Decodable {
      BreedsListModel(status: "", contents: Array(repeating: "a", count: 200)) as! T
    }
    
    func get(endpoint: DogsClient.Endpoint) async throws -> Data {
      (UIImage(systemName: "circle")?.pngData())!
    }
  }
}
