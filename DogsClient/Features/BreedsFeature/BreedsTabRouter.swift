//
//  BreedsTabRouter.swift
//  DogsClient
//
//  Created by Petru Lutenco on 26.09.2022.
//

import SwiftUI

protocol BreedsTabRouterProtocol: TabRouterProtocol where TabRoute == BreedsTabRoute {
}

class BreedsTabRouter: BreedsTabRouterProtocol {
  init(tabRoute: BreedsTabRoute) {
    self.tabRoute = tabRoute
  }
  
  var tabRoute: BreedsTabRoute
  
  @ViewBuilder func tab(for route: BreedsTabRoute) -> some View {
    switch route {
      case .all(let breed):
        createAllTabView(breed)
      case .subbreeds(let breed, let subbreedsList):
        createSubbreedsTabView(breed: breed, subbreedsList: subbreedsList)
    }
  }
  
  private func createAllTabView(_ breed: String) -> some View {
    let viewModel = DogsPhotosViewModel(
      breed: breed,
      subbreed: nil,
      apiService: DIContainer.shared.resolve(ApiProtocol.self),
      dispatcher: DIContainer.shared.resolve(DispatcherProtocol.self)
    )
    
    return DogsPhotosView(viewModel: viewModel, router: DogsPhotosRouter())
  }
  
  private func createSubbreedsTabView(breed: String, subbreedsList: [String]) -> some View {
    let subbreedViewModel = SubbreedsViewModel(breed: breed, subbreeds: subbreedsList)
    return SubbreedsView(viewModel: subbreedViewModel, router: SubbreedsRouter())
  }
}
