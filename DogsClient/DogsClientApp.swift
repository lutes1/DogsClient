//
//  DogsClientApp.swift
//  DogsClient
//
//  Created by Petru Lutenco on 08.09.2022.
//

import SwiftUI

@main
struct DogsClientApp: App {
  var body: some Scene {
    WindowGroup {
      HomeView(viewModel: HomeViewModel(apiService: Api(networkProvider: URLSession.shared)), router: HomeRouter())
    }
  }
}
