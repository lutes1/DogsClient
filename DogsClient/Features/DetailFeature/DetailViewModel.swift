//
//  DetailViewModel.swift
//  DogsClient
//
//  Created by Petru Lutenco on 20.09.2022.
//

import UIKit

protocol DogDetailViewModelProtocol: ViewModelProtocol {
  init(image: UIImage)
  var image: UIImage { get }
}

class DetailViewModel: DogDetailViewModelProtocol {
  required init(image: UIImage) {
    self.image = image
  }
  
  var image: UIImage
}
