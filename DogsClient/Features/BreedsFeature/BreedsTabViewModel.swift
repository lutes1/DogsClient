//
//  BreedsTabViewModel.swift
//  DogsClient
//
//  Created by Petru Lutenco on 26.09.2022.
//

import Foundation

protocol BreedsTabViewModelProtocol: ViewModelProtocol {
  init(breed: String, subbreeds: [String])
  var breed: String { get }
  var subbreeds: [String]  { get }
}

class BreedsTabViewModel: BreedsTabViewModelProtocol {
  private(set) var breed: String
  private(set) var subbreeds: [String]
  
  required init(breed: String, subbreeds: [String]) {
    self.breed = breed
    self.subbreeds = subbreeds
  }  
}
