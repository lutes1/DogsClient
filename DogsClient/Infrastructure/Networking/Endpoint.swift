//
//  Endpoint.swift
//  DogsClient
//
//  Created by Petru Lutenco on 13.09.2022.
//

import Foundation

enum Endpoint: Equatable {
  case allBreeds
  case allBreedsWithSubbreeds
  case picturesOfBreed(String)
  
  private var urlString: String {
    switch self {
      case .allBreeds:
        return "breeds/list"
      case .allBreedsWithSubbreeds:
        return "breeds/list/all"
      case .picturesOfBreed(let breedName):
        return "breed/\(breedName)/images"
    }
  }
  
  var url: URL {
     get throws {
      guard let url = URL(string: Constants.baseUrl + self.urlString) else {
        throw UrlCreationError.invalidUrl
      }
      
      return url
    }
  }
}

enum UrlCreationError: Error {
case invalidBaseUrl
case invalidUrl
}
