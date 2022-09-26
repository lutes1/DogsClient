//
//  Api.swift
//  DogsClient
//
//  Created by Petru Lutenco on 13.09.2022.
//

import Foundation

class Api: ApiProtocol {
  required init(networkProvider: NetworkProviderProtocol) {
    self.networkProvider = networkProvider
  }
  
  private let networkProvider: NetworkProviderProtocol
  
  func get<T: Decodable>(endpoint: Endpoint) async throws -> T {
    let (data, _) = try await networkProvider.data(from: try endpoint.url)
    let model = try JSONDecoder().decode(T.self, from: data)
    return model
  }
  
  func get(endpoint: Endpoint) async throws -> Data {
    let (data, _) = try await networkProvider.data(from: try endpoint.url)
    return data
  }
}

class Constants {
  static let baseUrl = "https://dog.ceo/api/"
}

extension URLSession: NetworkProviderProtocol {
}
