//
//  TestingRegisterer.swift
//  DogsClient
//
//  Created by Petru Lutenco on 21.09.2022.
//

import Foundation
import UIKit

class UITestingRegisterer: Registerer {
  override func setup() {
    super.setup()
    DIContainer.shared.register(NetworkProviderProtocol.self, with: NetworkProviderMock.init)
    DIContainer.shared.register(ApiProtocol.self, with: ApiMock.init)
  }
}

fileprivate extension UITestingRegisterer {
  class NetworkProviderMock: NetworkProviderProtocol {
    func data(from: URL) async throws -> (Data, URLResponse) {
      (.init(), .init())
    }
  }
  
  class ApiMock: ApiProtocol {
    required init(networkProvider: NetworkProviderProtocol) {
    }
    
    func get<T>(endpoint: Endpoint) async throws -> T where T : Decodable {
      switch endpoint {
        case .allBreeds:
          return BreedsListModel(status: "", contents: ["1","2","3","4","5"]) as! T
        case .picturesOfBreed:
          return BreedsListModel(status: "", contents: ["0", "0", "0", "0", "0"]) as! T
        case .allBreedsWithSubbreeds:
          return BreedsListWithSubbreedsModel(status: "", contents: ["hound": ["dog"], "hound2": ["dog", "dog2"]]) as! T
        default:
          fatalError("You are using the mocked API with an endpoint (\(endpoint)) that is not implemented")
      }
    }
    
    func get(endpoint: Endpoint) async throws -> Data {
      switch endpoint {
        case .picture:
          let image = UIImage(named: "test-image")!
          let data = image.jpegData(compressionQuality: 1)!
          return data
        default:
          fatalError("You are using the mocked API with an endpoint (\(endpoint)) that is not implemented")
      }
    }
  }
}
