//
//  Dispatcher.swift
//  DogsClient
//
//  Created by Petru Lutenco on 29.09.2022.
//

import Foundation

protocol DispatcherProtocol {
  func main(_ action: @escaping () -> ())
  func main(_ action: @escaping () -> ()) async
}

class Dispatcher: DispatcherProtocol {
  func main(_ action: @escaping () -> ()) {
    DispatchQueue.main.async {
      action()
    }
  }
  
  func main(_ action: @escaping () -> ()) async {
    await MainActor.run {
      action()
    }
  }
}
