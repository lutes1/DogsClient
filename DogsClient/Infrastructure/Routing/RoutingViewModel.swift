//
//  RoutingViewModel.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

protocol ModalViewModelProtocol: ViewModelProtocol {
  associatedtype ModalRoute: Route
  var modalRoute: ModalRoute? { get set }
}

protocol NavigatingViewModelProtocol: ViewModelProtocol {
  associatedtype NavigationRoute: Route
  var navigationRoute: NavigationRoute? { get set }
}

protocol TabViewModelProtocol: ViewModelProtocol {
  associatedtype TabRoute: Route
  var tabRoute: TabRoute { get set }
}
