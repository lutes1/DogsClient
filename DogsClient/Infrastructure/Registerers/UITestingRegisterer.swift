//
//  TestingRegisterer.swift
//  DogsClient
//
//  Created by Petru Lutenco on 21.09.2022.
//

import Foundation
import UIKit
import Combine

class UITestingRegisterer: Registerer {
  override func setup() {
    super.setup()
    DIContainer.shared.register(NetworkProviderProtocol.self, with: NetworkProviderMock.init)
    DIContainer.shared.register(ApiProtocol.self, with: ApiMock.init)
  }
}

fileprivate extension UITestingRegisterer {
  class NetworkProviderMock: NetworkProviderProtocol {
    func dataPublisher(for: URL) -> AnyPublisher<Data, URLError> {
      Future<Data, URLError> { promise in
        promise(Result.success(Data()))
      }
      .eraseToAnyPublisher()
    }
  }
  
  class ApiMock: ApiProtocol {
    required init(networkProvider: NetworkProviderProtocol) {
    }

    func get(endpoint: Endpoint) -> AnyPublisher<Data, URLError> {
      Future { promise in
        switch endpoint {
          case .picture:
            let image = UIImage(named: "test-image")!
            let data = image.jpegData(compressionQuality: 1)!
            promise(Result.success(data))
          
          case .allBreeds:
            promise(Result.success((try? JSONEncoder().encode(BreedsListModel(status: "", contents: ["1","2","3","4","5"])))!))
          
          case .picturesOfBreed:
            promise(Result.success((try? JSONEncoder().encode(BreedsListModel(status: "", contents: ["0", "0", "0", "0", "0"])))!))
          
          case .allBreedsWithSubbreeds:
            promise(Result.success((try? JSONEncoder().encode(BreedsListWithSubbreedsModel(status: "", contents: ["hound": ["dog"], "hound2": ["dog", "dog2"]])))!))
          
          default:
            fatalError("You are using the mocked API with an endpoint (\(endpoint)) that is not implemented")
        }
      }
      .eraseToAnyPublisher()
    }
  }
}
