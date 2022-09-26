//
//  BreedsTabRoutes.swift
//  DogsClient
//
//  Created by Petru Lutenco on 26.09.2022.
//

import Foundation

enum BreedsTabRoute: Route {
  case all(String)
  case subbreeds(String, [String])
  
  var id: Self {
    self
  }
}
