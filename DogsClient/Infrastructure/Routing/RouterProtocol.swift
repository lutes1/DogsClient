//
//  RouterProtocol.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

import SwiftUI

protocol RouterProtocol {
  associatedtype ModalRoute: Route
  associatedtype ModalDestination: View
  
  associatedtype NavigationRoute: Route
  associatedtype NavigationDestination: View
  
  @ViewBuilder func destination(for route: NavigationRoute?) -> NavigationDestination
  @ViewBuilder func modal(for route: ModalRoute?) -> ModalDestination
  init()
}

extension RouterProtocol {
  func destination(for route: EmptyRoute?) -> EmptyView {
    EmptyView()
  }
  
  func modal(for route: EmptyRoute?) -> EmptyView {
    EmptyView()
  }
}

enum EmptyRoute: Route {
  var id: String {
    ""
  }
}
