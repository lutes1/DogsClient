//
//  HomeViewModel.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//
import Foundation

protocol HomeViewModelProtocol: RoutingViewModelProtocol
  where NavigationRoute == HomeNavigationRoute {
  func loadPlainBreeds() async throws
  func loadWithSubBreeds() async throws
  var breeds: [String] { get }
  var breedsWithSubBreeds:  [Subbreed] { get }
}

class HomeViewModel: NavigatingViewModel<HomeNavigationRoute>, HomeViewModelProtocol {
  private let apiService: ApiProtocol
  
  init(apiService: ApiProtocol) {
    self.apiService = apiService
  }
  
  @Published private(set) var breeds: [String] = []
  @Published private(set) var breedsWithSubBreeds: [Subbreed] = []
  
  func loadPlainBreeds() async throws {
    let breeds: ApiModel = try await apiService.get(endpoint: .allBreeds)
    
    await MainActor.run {
      self.breeds = breeds.contents
    }
  }
  
  func loadWithSubBreeds() async throws {
    let withSubBreeds: SubbreedsApiModel = try await apiService.get(endpoint: .allBreedsWithSubbreeds)
    let subBreeds = withSubBreeds.contents.map { item in
      Subbreed(breed: item.key, subBreeds: item.value)
    }.filter {
      item in item.subBreeds.count > 0
    }
    
    await MainActor.run {
      self.breedsWithSubBreeds = subBreeds
    }
  }
}

struct ApiModel: Decodable {
  let status: String
  let contents: [String]
  
  private enum CodingKeys: String, CodingKey {
    case status
    case contents = "message"
  }
}

struct SubbreedsApiModel: Decodable {
  let status: String
  let contents: [String:[String]]
  
  private enum CodingKeys: String, CodingKey {
    case status
    case contents = "message"
  }
}

struct Subbreed: Identifiable {
  var id = UUID()
  let breed: String
  let subBreeds: [String]
}
