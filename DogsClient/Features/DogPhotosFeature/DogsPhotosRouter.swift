//
//  DogsPhotosRouter.swift
//  DogsClient
//
//  Created by Petru Lutenco on 26.09.2022.
//

import UIKit
import SwiftUI

protocol DogsPhotosRouterProtocol: ModalRouterProtocol where ModalRoute == DogsPhotosModalRoute{
  func presentDetail(_ image: UIImage)
}

class DogsPhotosRouter: DogsPhotosRouterProtocol {
  
  @Published var modalRoute: DogsPhotosModalRoute?
  
  func presentDetail(_ image: UIImage) {
    modalRoute = .detail(image)
  }
  
  @ViewBuilder func modal() -> some View {
    if let route = modalRoute {
      switch route {
        case .detail(let image):
          DogDetailView(viewModel: DetailViewModel(image: image))
      }
    }
  }
}
