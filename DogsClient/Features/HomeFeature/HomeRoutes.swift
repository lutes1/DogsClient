//
//  HomeRoute.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

enum HomeNavigationRoute: Route {
  case detail(String, [String])
  
  var id: Self {
    self
  }
}

enum HomeModalRoute: Route {
  case modal
  
  var id: Self {
    self
  }
}
