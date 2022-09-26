//
//  DetailView.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

import SwiftUI

struct DogsPhotosView<ViewModel: DogsPhotosViewModelProtocol, Router: DogsPhotosRouterProtocol> : View {
  @ObservedObject var viewModel: ViewModel
  @State var task: Task<Void, Never>?
  let router: Router
  
  var body: some View {
    List(viewModel.images, id: \.self) { image in
      Button {
        viewModel.modalRoute = .detail(image)
      } label: {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      }
      .accessibilityIdentifier("photoButton")
    }
    .sheet(item: $viewModel.modalRoute) { route in
      router.modal(for: viewModel.modalRoute)
    }
    .navigationTitle("\(viewModel.subbreed?.capitalized ?? "") \(viewModel.breed.capitalized)")
    .onAppear {
      task = Task {
        do {
          try await viewModel.loadPictures()
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

struct DogsPhotosView_Previews: PreviewProvider {
  static var previews: some View {
    DogsPhotosView(viewModel: DogsPhotosViewModel(breed: "hound", apiService: Api(networkProvider: URLSession.shared)), router: DogsPhotosRouter())
  }
}
