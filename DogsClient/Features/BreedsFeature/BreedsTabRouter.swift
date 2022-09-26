//
//  BreedsTabRouter.swift
//  DogsClient
//
//  Created by Petru Lutenco on 26.09.2022.
//

import SwiftUI

protocol BreedsTabRouterProtocol: TabRouterProtocol where TabRoute == BreedsTabRoute {
}

struct BreedsTabRouter: BreedsTabRouterProtocol {
  @ViewBuilder func tab(for route: BreedsTabRoute) -> some View {
    switch route {
      case .all(let breed):
        let viewModel = DogsPhotosViewModel(breed: breed, subbreed: nil, apiService: DIContainer.shared.resolve(ApiProtocol.self))
        DogsPhotosView(viewModel: viewModel, router: DogsPhotosRouter())
      case .subbreeds(let breed, let subbreedsList):
        let subbreedViewModel = SubbreedsViewModel(breed: breed, subbreeds: subbreedsList)
        SubbreedsView(viewModel: subbreedViewModel, router: SubbreedsRouter())
    }
  }
}
