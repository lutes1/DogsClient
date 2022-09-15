//
//  RoutingViewModel.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

import Foundation

protocol RoutingViewModelProtocol: ViewModelProtocol {
  associatedtype ModalRoute: Route
  associatedtype NavigationRoute: Route
  var modalRoute: ModalRoute? { get set }
  var navigationRoute: NavigationRoute? { get set }
}

class RoutingViewModel<NavigationRoute: Route, ModalRoute: Route> : RoutingViewModelProtocol {
  @Published var modalRoute: ModalRoute?
  @Published var navigationRoute: NavigationRoute?
}

class NavigatingViewModel<NavigationRoute: Route> : RoutingViewModel<NavigationRoute, EmptyRoute> {
}

class ModalPresentingViewModel<ModalRoute: Route> : RoutingViewModel<EmptyRoute, ModalRoute> {
}
