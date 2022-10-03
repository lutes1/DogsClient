//
//  HomeViewModel.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//
import Foundation
import Combine

protocol HomeViewModelProtocol: ViewModelProtocol {
  func load() async throws
  var breeds: [Breed] { get }
}

class HomeViewModel: HomeViewModelProtocol {
  private let apiService: ApiProtocol
  
  @Published private(set) var breeds: [Breed] = []
  
  init(apiService: ApiProtocol) {
    self.apiService = apiService
  }
  
  func load() async throws {
    let withSubBreeds: BreedsListWithSubbreedsModel = try await apiService.get(endpoint: .allBreedsWithSubbreeds)
    let breeds = withSubBreeds.contents
      .map { item in
        Breed(name: item.key, subBreeds: item.value)
      }
      .sorted(by: { $0.name < $1.name })
    
    await MainActor.run {
      self.breeds = breeds
    }
  }
}
