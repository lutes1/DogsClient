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
  case picturesOfSubBreeds(String, String)
  case picture(String)
  
  private var urlString: String {
    switch self {
      case .allBreeds:
        return "breeds/list"
      case .allBreedsWithSubbreeds:
        return "breeds/list/all"
      case .picturesOfBreed(let breedName):
        return "breed/\(breedName)/images"
      case .picturesOfSubBreeds(let breedName, let subreedName):
        return "breed/\(breedName)/\(subreedName)/images"
      case .picture(let urlString):
        return urlString
    }
  }
  
  var url: URL {
    get throws {
      var urlString: String
      
      switch self {
        case .picture:
          urlString = self.urlString
        default:
          urlString = Constants.baseUrl + self.urlString
      }
      
      guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedString) else {
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
