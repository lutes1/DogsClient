//
//  Api.swift
//  DogsClient
//
//  Created by Petru Lutenco on 13.09.2022.
//

import Foundation
import Combine

class Api: ApiProtocol {
  let networkProvider: NetworkProviderProtocol
  
  required init(networkProvider: NetworkProviderProtocol) {
    self.networkProvider = networkProvider
  }
  
  func get(endpoint: Endpoint) -> AnyPublisher<Data, URLError> {
    self.networkProvider.dataPublisher(for: (try? endpoint.url)!)
  }
}

extension URLSession: NetworkProviderProtocol {
  func dataPublisher(for url: URL) -> AnyPublisher<Data, URLError> {
    self.dataTaskPublisher(for: url)
      .map {
        $0.data
      }
      .eraseToAnyPublisher()
  }
}
