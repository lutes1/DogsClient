//
//  BreedsTabView.swift
//  DogsClient
//
//  Created by Petru Lutenco on 26.09.2022.
//

import SwiftUI


struct BreedsTabView<ViewModel: BreedsTabViewModelProtocol, Router: BreedsTabRouterProtocol>: View {
  @ObservedObject
  private(set) var viewModel: ViewModel
  private(set) var router: Router
  
  var body: some View {
    TabView(selection: $viewModel.tabRoute) {
      router.tab(for: .all(viewModel.breed))
        .tabItem {
          VStack {
            Text("All")
            Image(systemName: "rectangle.grid.1x2.fill")
          }
        }
        .tag(BreedsTabRoute.all(viewModel.breed))
      
      router.tab(for: .subbreeds(viewModel.breed, viewModel.subbreeds))
        .tabItem {
          VStack {
            Text("Subbreeds")
            Image(systemName: "list.bullet.below.rectangle")
          }
        }
        .tag(BreedsTabRoute.subbreeds(viewModel.breed, viewModel.subbreeds))
    }
    .navigationTitle(viewModel.breed)
  }
}

struct BreedsTabView_Previews: PreviewProvider {
  static var previews: some View {
    BreedsTabView(viewModel: BreedsTabViewModel(breed: "hound", subbreeds: ["afghan"]), router: BreedsTabRouter())
  }
}

