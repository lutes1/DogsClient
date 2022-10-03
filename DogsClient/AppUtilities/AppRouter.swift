//
//  AppRouter.swift
//  DogsClient
//
//  Created by Petru Lutenco on 03.10.2022.
//

import SwiftUI

class AppRouter: NavigationRouterProtocol {
  @Published var navigationRoute: AppRoute? = .home
  
  func destination() -> some View {
    if let route = navigationRoute {
      switch route {
        case .home:
          HomeView(viewModel: HomeViewModel(apiService: DIContainer.shared.resolve(ApiProtocol.self)), router: HomeRouter())
      }
    }
  }
}

enum AppRoute: Route {
  case home
  
  var id: Self {
    self
  }
}
