//
//  Registerer.swift
//  DogsClient
//
//  Created by Petru Lutenco on 21.09.2022.
//

import Foundation

class Registerer {
  func setup() {
    DIContainer.shared.register(NetworkProviderProtocol.self, as: URLSession.shared)
    
    DIContainer.shared.register(AppRouter.self, with: AppRouter.init)
    DIContainer.shared.register(ApiProtocol.self, with: Api.init)
    DIContainer.shared.register(DispatcherProtocol.self, with: Dispatcher.init)
  }
}
