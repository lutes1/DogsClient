//
//  TabRouterProtocol.swift
//  DogsClient
//
//  Created by Petru Lutenco on 03.10.2022.
//

import SwiftUI

protocol TabRouterProtocol: ObservableObject {
  associatedtype TabRoute: Route
  associatedtype TabDestination: View
  var tabRoute: TabRoute { get set }
  @ViewBuilder func tab(for route: TabRoute) -> TabDestination
}
