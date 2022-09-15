//
//  BreedViewModel.swift
//  DogsClient
//
//  Created by Petru Lutenco on 13.09.2022.
//

import UIKit
import SwiftUI

protocol BreedViewModelProtocol: RoutingViewModelProtocol where ModalRoute == BreedRoute {
  var breed: String { get }
  var images: [UIImage] { get }
  func loadUrls() async throws
  init(breed: String, apiService: ApiProtocol)
}

class BreedViewModel: ModalPresentingViewModel<BreedRoute>, BreedViewModelProtocol {
  private let apiService: ApiProtocol

  required init(breed: String, apiService: ApiProtocol) {
    self.breed = breed
    self.apiService = apiService
  }

  @Published private(set) var breed: String
  @Published var images: [UIImage] = []
  
  func loadUrls() async throws {
    let result: ApiModel = try await apiService.get(endpoint: .picturesOfBreed(self.breed))
    
    for link in result.contents {
      guard let url = URL(string: link) else {
        continue
      }
      
      let data = try Data(contentsOf: url)
      
      guard let image = UIImage(data: data) else {
        continue
      }
      
      await MainActor.run {
        self.images.append(image)
      }
    }
  }
}

enum BreedRoute: Route {
  case detail(UIImage)
  
  var id: Self {
    self
  }
}

struct BreedRouter: RouterProtocol {
  @ViewBuilder func modal(for route: BreedRoute?) -> some View {
    if let route = route {
      switch route {
        case .detail(let image):
          DetailView(viewModel: DetailViewModel(image: image))
      }
    }
  }
}
