//
//  SubbreedsViewModel.swift
//  DogsClient
//
//  Created by Petru Lutenco on 26.09.2022.
//

import Combine

protocol SubbreedsViewModelProtocol: NavigatingViewModelProtocol
  where NavigationRoute == SubbreedsNavigationRoute {
  init(breed: String, subbreeds: [String])
  
  var breed: String { get }
  var subbreeds: [String]  { get }
}

class SubbreedsViewModel: SubbreedsViewModelProtocol {
  @Published var navigationRoute: SubbreedsNavigationRoute?
  
  private(set) var breed: String
  private(set) var subbreeds: [String]
  
  required init(breed: String, subbreeds: [String]) {
    self.breed = breed
    self.subbreeds = subbreeds
  }
}
