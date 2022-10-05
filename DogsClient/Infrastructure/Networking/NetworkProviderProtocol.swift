//
//  NetworkProvider.swift
//  DogsClient
//
//  Created by Petru Lutenco on 14.09.2022.
//

import Foundation
import Combine

protocol NetworkProviderProtocol {
  func dataPublisher(for: URL) -> AnyPublisher<Data, URLError>
}
