//
//  DetailView.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

import SwiftUI

struct BreedView<ViewModel: BreedViewModelProtocol, Router: RouterProtocol> : View
  where ViewModel.ModalRoute == Router.ModalRoute,
        ViewModel.NavigationRoute == Router.NavigationRoute {
  @ObservedObject var viewModel: ViewModel
  @State var task: Task<Void, Never>?
  let router: Router
  
  var body: some View {
    if #available(iOS 15, *) {
      let _ = Self._printChanges()
    }
    
    List(viewModel.images, id: \.self) { image in
      Button {
        viewModel.modalRoute = .detail(image)
      } label: {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      }
    }
    .sheet(item: $viewModel.modalRoute) { route in
      router.modal(for: viewModel.modalRoute)
    }
    .navigationTitle(viewModel.breed)
    .onAppear {
      task = Task {
        do {
          try await viewModel.loadUrls()
        }
        catch {
          print(error)
        }
      }
    }
    .onDisappear {
      task?.cancel()
    }
  }
}

struct BreedView_Previews: PreviewProvider {
    static var previews: some View {
      BreedView(viewModel: BreedViewModel(breed: "hound", apiService: Api(networkProvider: URLSession.shared)), router: BreedRouter())
    }
}
