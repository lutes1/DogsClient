//
//  HomeRouter.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

import SwiftUI

protocol HomeRouterProtocol: NavigationRouterProtocol where NavigationRoute == HomeNavigationRoute {
}

class HomeRouter: HomeRouterProtocol {
  @Published var navigationRoute: HomeNavigationRoute?
  
  @ViewBuilder func destination() -> some View {
    if let route = navigationRoute {
      switch route {
        case .detail(let breed, let subBreed):
          makeBreedView(for: breed, with: subBreed)
      }
    }
  }
  
  private func makeBreedView(for breed: String, with subbreedsList: [String]) -> some View {
    let breedsTabViewModel = BreedsTabViewModel(breed: breed, subbreeds: subbreedsList)
    let initialRoute: BreedsTabRoute = subbreedsList.isEmpty ? .all(breed): .subbreeds(breed, subbreedsList)
    return BreedsTabView(viewModel: breedsTabViewModel, router: BreedsTabRouter(tabRoute: initialRoute))
  }
}
