//
//  NetworkProvider.swift
//  DogsClient
//
//  Created by Petru Lutenco on 14.09.2022.
//

import Foundation

protocol NetworkProviderProtocol {
  func data(from: URL) async throws -> (Data, URLResponse)
}
