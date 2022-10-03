//
//  DetailView.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

import SwiftUI

struct DogsPhotosView<ViewModel: DogsPhotosViewModelProtocol, Router: DogsPhotosRouterProtocol> : View {
  @ObservedObject var viewModel: ViewModel
  @ObservedObject var router: Router
  @State var task: Task<Void, Never>?
  
  var body: some View {
    List(viewModel.images, id: \.self) { image in
      Image(uiImage: image)
        .resizable()
        .scaledToFit()
        .accessibilityIdentifier("image")
        .onTapGesture {
          router.presentDetail(image)
        }
    }
    .sheet(item: $router.modalRoute) { route in
      router.modal()
    }
    .navigationTitle(viewModel.title)
    .onAppear {
      task = Task {
        do {
          try await viewModel.load()
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
    DogsPhotosView(viewModel: DogsPhotosViewModel(breed: "hound", apiService: Api(networkProvider: URLSession.shared), dispatcher: Dispatcher()), router: DogsPhotosRouter())
  }
}
