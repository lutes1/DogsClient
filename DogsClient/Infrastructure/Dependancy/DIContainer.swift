//
//  DIContainer.swift
//  DogsClient
//
//  Created by Petru Lutenco on 20.09.2022.
//
import Swinject
import SwinjectAutoregistration
import Foundation
import UIKit

class DIContainer {
  private init() { }
  static let shared = DIContainer()
  
  private let container = Container()
  
  func resolve<T>(_ type: T.Type) -> T {
    guard let resolved = container.resolve(type) else {
      fatalError("Type \(type) was not registered in the container.")
    }
    
    return resolved
  }
  
  func register<T>(_ type: T.Type, as object: T) {
    container.register(type, factory: { r in object })
  }
  
  func register<T>(_ type: T.Type, with initializer: @escaping () -> T) {
    container.autoregister(T.self, initializer: initializer)
  }
  
  func register<T, A>(_ type: T.Type, with initializer: @escaping (A) -> T) {
    container.autoregister(T.self, initializer: initializer)
  }
}
