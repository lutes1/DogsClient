//
//  RestApi.swift
//  DogsClient
//
//  Created by Petru Lutenco on 13.09.2022.
//

import Foundation

protocol ApiProtocol {
  init(networkProvider: NetworkProviderProtocol)
  func get<T: Decodable>(endpoint: Endpoint) async throws -> T
}
