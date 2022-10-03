//
//  DogsClientApp.swift
//  DogsClient
//
//  Created by Petru Lutenco on 08.09.2022.
//

import SwiftUI

@main
struct DogsClientApp: App {
  private let router: AppRouter
  
  init() {
    let registerer: Registerer!
    if ProcessInfo.processInfo.arguments.contains("uitesting") {
      registerer = UITestingRegisterer()
    }
    else {
      registerer = Registerer()
    }
    
    registerer.setup()
    
    router = AppRouter()
  }
  
  var body: some Scene {
    WindowGroup {
      router.destination()
    }
  }
}
