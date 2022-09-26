//
//  RouterProtocol.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

import SwiftUI

protocol NavigationRouterProtocol {
  associatedtype NavigationRoute: Route
  associatedtype NavigationDestination: View
  @ViewBuilder func destination(for route: NavigationRoute?) -> NavigationDestination
}

protocol ModalRouterProtocol {
  associatedtype ModalRoute: Route
  associatedtype ModalDestination: View
  
  @ViewBuilder func modal(for route: ModalRoute?) -> ModalDestination
}


protocol TabRouterProtocol {
  associatedtype TabRoute: Route
  associatedtype TabDestination: View
  
  @ViewBuilder func tab(for route: TabRoute) -> TabDestination
}
