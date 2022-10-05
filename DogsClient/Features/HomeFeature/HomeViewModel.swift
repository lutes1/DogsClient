//
//  HomeViewModel.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//
import Foundation
import Combine

protocol HomeViewModelProtocol: ViewModelProtocol {
  func load()
  var breeds: [Breed] { get }
}

class HomeViewModel: HomeViewModelProtocol {
  private let apiService: ApiProtocol
  private var cancellables: [AnyCancellable] = []
  
  @Published private(set) var breeds: [Breed] = []
  
  init(apiService: ApiProtocol) {
    self.apiService = apiService
  }
  
  func load() {
    apiService.get(endpoint: .allBreedsWithSubbreeds)
      .decode(type: BreedsListWithSubbreedsModel.self, decoder: JSONDecoder())
//      .flatMap { data in
//        Just(data)
//            .catch { data in
//              Just(BreedsListWithSubbreedsModel.init(status: "", contents: [:]))
//            }
//      }
      .assertNoFailure()
      .map(\.contents)
      .map { item in
        return zip(item.keys, item.values)
          .map { key, value in
            Breed(name: key, subBreeds: value)
          }
          .sorted(by: { $0.name < $1.name })
      }
      .receive(on: DispatchQueue.main)
      .sink { [weak self] item in
        guard let self = self else {
          return
        }
        
        self.breeds = item
      }
      .store(in: &cancellables)
  }
}
