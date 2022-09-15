//
//  MetadataView.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

import SwiftUI

struct DetailView<ViewModel: DetailViewModelProtocol>: View {
  @ObservedObject var viewModel: ViewModel
  @State var scaled = false
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
  }
}

struct MetadataView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(viewModel: DetailViewModel(image: UIImage(named: "test-image")!))
  }
}

protocol DetailViewModelProtocol: ViewModelProtocol {
  init(image: UIImage)
  var image: UIImage { get }
}

class DetailViewModel: DetailViewModelProtocol {
  required init(image: UIImage) {
    self.image = image
  }
  
  var image: UIImage
}
