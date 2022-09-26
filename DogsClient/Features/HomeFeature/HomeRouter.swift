//
//  HomeRouter.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

import SwiftUI

protocol HomeRouterProtocol: NavigationRouterProtocol where NavigationRoute == HomeNavigationRoute {
}

struct HomeRouter: HomeRouterProtocol {
  @ViewBuilder func destination(for route: HomeNavigationRoute?) -> some View {
    if let route = route {
      switch route {
        case .detail(let breed, let subBreed): makeBreedView(for: breed, with: subBreed)
      }
    }
  }
  
  private func makeBreedView(for breed: String, with subbreedsList: [String]) -> some View {
    let breedsTabViewModel = BreedsTabViewModel(breed: breed, subbreeds: subbreedsList)
    return BreedsTabView(viewModel: breedsTabViewModel, router: BreedsTabRouter())
  }
}
