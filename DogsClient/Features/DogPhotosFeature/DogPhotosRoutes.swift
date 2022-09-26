//
//  DogPhotosRoutes.swift
//  DogsClient
//
//  Created by Petru Lutenco on 26.09.2022.
//

import UIKit

enum DogsPhotosModalRoute: Route {
  case detail(UIImage)
  
  var id: Self {
    self
  }
}
