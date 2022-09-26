//
//  SubbreedRoutes.swift
//  DogsClient
//
//  Created by Petru Lutenco on 26.09.2022.
//

import Foundation

enum SubbreedsNavigationRoute: Route {
  case photos(String, String)
  
  var id: Self {
    self
  }
}
