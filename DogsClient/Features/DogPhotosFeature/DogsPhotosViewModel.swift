//
//  BreedViewModel.swift
//  DogsClient
//
//  Created by Petru Lutenco on 13.09.2022.
//

import UIKit
import SwiftUI

protocol DogsPhotosViewModelProtocol: ModalViewModelProtocol where ModalRoute == DogsPhotosModalRoute {
  var breed: String { get }
  var subbreed: String? { get }
  var images: [UIImage] { get }
  func loadPictures() async throws
  init(breed: String, subbreed: String?, apiService: ApiProtocol)
}

class DogsPhotosViewModel: DogsPhotosViewModelProtocol {
  @Published private(set) var breed: String
  @Published private(set) var subbreed: String?
  @Published private(set) var images: [UIImage] = []
  @Published var modalRoute: DogsPhotosModalRoute?
  
  private let apiService: ApiProtocol

  required init(breed: String, subbreed: String? = nil, apiService: ApiProtocol) {
    self.breed = breed
    self.subbreed = subbreed
    self.apiService = apiService
  }
  
  func loadPictures() async throws {
    let endpoint: Endpoint!
    
    if let subbreed = self.subbreed {
      endpoint = .picturesOfSubBreeds(self.breed, subbreed)
    } else {
      endpoint = .picturesOfBreed(self.breed)
    }
    
    let result: BreedsListModel = try await apiService.get(endpoint: endpoint)
    
    for link in result.contents {
      let data = try await apiService.get(endpoint: .picture(link))
      
      guard let image = UIImage(data: data) else {
        continue
      }
      
      await MainActor.run {
        self.images.append(image)
      }
    }
  }
}
