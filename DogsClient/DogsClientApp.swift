//
//  DogsClientApp.swift
//  DogsClient
//
//  Created by Petru Lutenco on 08.09.2022.
//

import SwiftUI

@main
struct DogsClientApp: App {
  init() {
    let registerer: Registerer!
    if ProcessInfo.processInfo.arguments.contains("uitesting") {
      registerer = UITestingRegisterer()
    }
    else {
      registerer = Registerer()
    }
    
    registerer.setup()
    
    router = DIContainer.shared.resolve(AppRouter.self)
  }
  
  private let router: AppRouter
  
  var body: some Scene {
    WindowGroup {
      router.destination(for: .home)
    }
  }
}

struct AppRouter: NavigationRouterProtocol {
  func destination(for route: AppRoute?) -> some View {
    if let route = route {
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

