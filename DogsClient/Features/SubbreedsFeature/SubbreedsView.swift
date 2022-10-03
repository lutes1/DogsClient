//
//  SubbreedsView.swift
//  DogsClient
//
//  Created by Petru Lutenco on 26.09.2022.
//

import SwiftUI

struct SubbreedsView<ViewModel: SubbreedsViewModelProtocol, Router: SubbreedsRouterProtocol>: View {
  @ObservedObject
  private(set) var viewModel: ViewModel
  
  @ObservedObject
  private(set) var router: Router
  
  var body: some View {
    if viewModel.subbreeds.isEmpty {
      Text("\(viewModel.breed.capitalized) has no sub-breeds")
        .foregroundColor(.gray)
    }
    else {
      List(viewModel.subbreeds, id: \.self) { subBreed in
        NavigationLink(
          subBreed,
          destination: router.destination(),
          tag: .photos(viewModel.breed, subBreed),
          selection: $router.navigationRoute)
      }
    }
  }
}

struct SubbreedsView_Previews: PreviewProvider {
  static var previews: some View {
    SubbreedsView(viewModel: SubbreedsViewModel(breed: "hound", subbreeds: ["blood", "english"]), router: SubbreedsRouter())
  }
}
