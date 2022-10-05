//
//  SubbreedsRouter.swift
//  DogsClient
//
//  Created by Petru Lutenco on 26.09.2022.
//

import SwiftUI

protocol SubbreedsRouterProtocol: NavigationRouterProtocol
  where NavigationRoute == SubbreedsNavigationRoute {
}

class SubbreedsRouter: SubbreedsRouterProtocol {
  @Published var navigationRoute: SubbreedsNavigationRoute?
  
  @ViewBuilder func destination() -> some View {
    if let route = navigationRoute {
      switch route {
        case .photos(let breed, let subbreed):
          let breedViewModel = DogsPhotosViewModel(breed: breed, subbreed: subbreed, apiService: DIContainer.shared.resolve(ApiProtocol.self))
          DogsPhotosView(viewModel: breedViewModel, router: DogsPhotosRouter())
      }
    }
  }
}
