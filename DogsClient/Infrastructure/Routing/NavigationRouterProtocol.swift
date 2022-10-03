//
//  RouterProtocol.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

import SwiftUI

protocol NavigationRouterProtocol: ObservableObject {
  associatedtype NavigationRoute: Route
  associatedtype NavigationDestination: View
  var navigationRoute: NavigationRoute? { get set }
  @ViewBuilder func destination() -> NavigationDestination
}

