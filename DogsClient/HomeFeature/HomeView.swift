//
//  ContentView.swift
//  DogsClient
//
//  Created by Petru Lutenco on 08.09.2022.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol, Router: RouterProtocol> : View
where Router.NavigationRoute == ViewModel.NavigationRoute {
  private let router: Router
  
  @ObservedObject private var viewModel: ViewModel
  
  init(viewModel: ViewModel, router: Router) {
    self.viewModel = viewModel
    self.router = router
  }
  
  var body: some View {
    NavigationView {
      List(viewModel.breeds, id: \.self) { breed in
        NavigationLink(
          destination: router.destination(for: viewModel.navigationRoute),
          tag: .detail(breed),
          selection: $viewModel.navigationRoute,
          label: { Text(breed) })
      }
      .onAppear {
        Task {
          do {
            try await viewModel.loadPlainBreeds()
          } catch {
            print(error)
          }
        }
      }
      .navigationTitle("Breeds")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(viewModel: HomeViewModel(apiService: Api(networkProvider: URLSession.shared)), router: HomeRouter())
  }
}
