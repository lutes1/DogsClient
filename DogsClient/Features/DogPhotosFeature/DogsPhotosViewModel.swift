//
//  BreedViewModel.swift
//  DogsClient
//
//  Created by Petru Lutenco on 13.09.2022.
//

import UIKit
import SwiftUI

protocol DogsPhotosViewModelProtocol: ViewModelProtocol {
  var breed: String { get }
  var subbreed: String? { get }
  var images: [UIImage] { get }
  var title: String { get }
  func load() async throws
  init(breed: String, subbreed: String?, apiService: ApiProtocol, dispatcher: DispatcherProtocol)
}

class DogsPhotosViewModel: DogsPhotosViewModelProtocol {
  private var photosLinks: [String] = []
  
  private let apiService: ApiProtocol
  private let dispatcher: DispatcherProtocol
  
  private(set) var breed: String
  private(set) var subbreed: String?
  private(set) var title: String
  @Published private(set) var images: [UIImage] = []
  
  required init(breed: String, subbreed: String? = nil, apiService: ApiProtocol, dispatcher: DispatcherProtocol) {
    self.breed = breed
    self.subbreed = subbreed
    self.apiService = apiService
    self.dispatcher = dispatcher
    
    self.title = "\(subbreed?.capitalized ?? "") \(breed.capitalized)"
  }
  
  func load() async throws {
    if photosLinks.isEmpty {
      try await loadPictureLinks()
    }
    
    try await self.loadImages()
  }
  
  private func loadPictureLinks() async throws {
    let endpoint: Endpoint!
    
    if let subbreed = self.subbreed {
      endpoint = .picturesOfSubBreeds(self.breed, subbreed)
    } else {
      endpoint = .picturesOfBreed(self.breed)
    }
    
    let result: BreedsListModel = try await apiService.get(endpoint: endpoint)
    
    photosLinks = result.contents
  }
  
  private func loadImages() async throws {
    try await self.loadAndAppendImages(at: Array(photosLinks))
  }
  
  private func loadAndAppendImages(at links: [String]) async throws {
    for link in links {
      let data = try await apiService.get(endpoint: .picture(link))
      
      guard let image = UIImage(data: data) else {
        continue
      }
      
      await dispatcher.main {
        self.images.append(image)
      }
    }
  }
}
