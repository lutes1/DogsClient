//
//  ModalRouterProtocol.swift
//  DogsClient
//
//  Created by Petru Lutenco on 03.10.2022.
//

import SwiftUI

protocol ModalRouterProtocol: ObservableObject {
  associatedtype ModalRoute: Route
  associatedtype ModalDestination: View
  var modalRoute: ModalRoute? { get set }
  @ViewBuilder func modal() -> ModalDestination
}
