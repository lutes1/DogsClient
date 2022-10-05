//
//  RestApi.swift
//  DogsClient
//
//  Created by Petru Lutenco on 13.09.2022.
//

import Foundation
import Combine

protocol ApiProtocol {
  init(networkProvider: NetworkProviderProtocol)
  func get(endpoint: Endpoint) -> AnyPublisher<Data, URLError>
}
