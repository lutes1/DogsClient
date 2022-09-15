//
//  HomeRouter.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

import SwiftUI

struct HomeRouter: RouterProtocol {
  @ViewBuilder func destination(for route: HomeNavigationRoute?) -> some View {
    if let route = route {
      switch route {
        case .detail(let breed): makeBreedView(for: breed)
      }
    }
  }
  
  private func makeBreedView(for breed: String) -> BreedView<BreedViewModel, BreedRouter> {
    let viewModel = BreedViewModel(breed: breed, apiService: Api(networkProvider: URLSession.shared))
    return BreedView(viewModel: viewModel, router: BreedRouter())
  }
}
