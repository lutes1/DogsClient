//
//  ContentView.swift
//  DogsClient
//
//  Created by Petru Lutenco on 08.09.2022.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol, Router: HomeRouterProtocol> : View {
  
  @ObservedObject private(set) var viewModel: ViewModel
  @ObservedObject private(set) var router: Router
  
  var body: some View {
    NavigationView {
      List(viewModel.breeds, id: \.name) { breed in
        NavigationLink(
          destination: router.destination(),
          tag: .detail(breed.name, breed.subBreeds),
          selection: $router.navigationRoute,
          label: {
            HStack {
              Text(breed.name)
                .font(.callout)
                .accessibilityIdentifier("navigationLinkLabel")
              if !breed.subBreeds.isEmpty {
                Spacer()
                Circle()
                  .fill(Color.green.opacity(0.5))
                  .frame(width: 20)
              }
            }
          }
        )
        .accessibilityIdentifier("navigationLink")
      }
      .navigationTitle("Breeds")
    }
    .onAppear {
      Task {
        do {
          try await viewModel.load()
        } catch {
          print(error)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(viewModel: HomeViewModel(apiService: Api(networkProvider: URLSession.shared)), router: HomeRouter())
  }
}
