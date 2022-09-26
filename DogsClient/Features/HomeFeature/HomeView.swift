//
//  ContentView.swift
//  DogsClient
//
//  Created by Petru Lutenco on 08.09.2022.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol, Router: HomeRouterProtocol> : View {
  
  @ObservedObject
  private(set) var viewModel: ViewModel
  
  private(set) var router: Router
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.breeds, id: \.name) { breed in
          NavigationLink(
            destination: router.destination(for: viewModel.navigationRoute),
            tag: .detail(breed.name, breed.subBreeds),
            selection: $viewModel.navigationRoute,
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
