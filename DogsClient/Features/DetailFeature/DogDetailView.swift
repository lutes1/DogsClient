//
//  MetadataView.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

import SwiftUI

struct DogDetailView<ViewModel: DogDetailViewModelProtocol>: View {
  @ObservedObject var viewModel: ViewModel
  @State var scaled = false
  
  // For testing purposes
  internal var didAppear: ((Self) -> Void)?
  
  var body: some View {
    Image(uiImage: viewModel.image)
      .resizable()
      .aspectRatio(contentMode: scaled ? .fill : .fit)
      .ignoresSafeArea()
      .onTapGesture {
        withAnimation {
          scaled.toggle()
        }
      }
      // For testing purposes
      .onAppear { self.didAppear?(self) }
      .accessibilityIdentifier("dogDetailImage")
  }
}

struct MetadataView_Previews: PreviewProvider {
  static var previews: some View {
    DogDetailView(viewModel: DetailViewModel(image: UIImage(named: "test-image")!))
  }
}
