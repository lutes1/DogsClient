//
//  DogsPhotosRouter.swift
//  DogsClient
//
//  Created by Petru Lutenco on 26.09.2022.
//

import UIKit
import SwiftUI

protocol DogsPhotosRouterProtocol: ModalRouterProtocol where ModalRoute == DogsPhotosModalRoute {
}

struct DogsPhotosRouter: DogsPhotosRouterProtocol {
  @ViewBuilder func modal(for route: DogsPhotosModalRoute?) -> some View {
    if let route = route {
      switch route {
        case .detail(let image):
          DogDetailView(viewModel: DetailViewModel(image: image))
      }
    }
  }
}
