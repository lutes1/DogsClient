//
//  BreedViewModel.swift
//  DogsClient
//
//  Created by Petru Lutenco on 13.09.2022.
//

import UIKit
import SwiftUI
import Combine

protocol DogsPhotosViewModelProtocol: ViewModelProtocol {
  var breed: String { get }
  var subbreed: String? { get }
  var images: [UIImage] { get }
  var title: String { get }
  func load()
  init(breed: String, subbreed: String?, apiService: ApiProtocol)
}

class DogsPhotosViewModel: DogsPhotosViewModelProtocol {
  private let apiService: ApiProtocol
  
  private(set) var breed: String
  private(set) var subbreed: String?
  private(set) var title: String
  private let api: ApiProtocol
  @Published private(set) var images: [UIImage] = []
  var cancellables: [AnyCancellable] = []
  
  required init(breed: String, subbreed: String? = nil, apiService: ApiProtocol) {
    self.breed = breed
    self.subbreed = subbreed
    self.apiService = apiService
    
    self.title = "\(subbreed?.capitalized ?? "") \(breed.capitalized)"
    self.api = DIContainer.shared.resolve(ApiProtocol.self)
  }
  
  func load() {
    let endpoint: Endpoint!
    
    if let subbreed = self.subbreed {
      endpoint = .picturesOfSubBreeds(self.breed, subbreed)
    } else {
      endpoint = .picturesOfBreed(self.breed)
    }
    
    self.api.get(endpoint: endpoint)
      .decode(type: BreedsListModel.self, decoder: JSONDecoder())
      .catch { error in
        print("JSON Error ! - ", error)
        return Just(BreedsListModel.init(status: "", contents: []))
      }
      .sink { [weak self] result in
        guard let self = self else {
          return
        }
        
        for link in result.contents {
          self.loadImage(at: link)
        }
      }
      .store(in: &cancellables)
  }
  
  private func loadImage(at link: String) {
    self.api.get(endpoint: .picture(link))
      .compactMap { data in
        UIImage(data: data)
      }
      .assertNoFailure()
      .receive(on: DispatchQueue.main)
      .sink { result in
        self.images.append(result)
      }
      .store(in: &self.cancellables)
  }
}

