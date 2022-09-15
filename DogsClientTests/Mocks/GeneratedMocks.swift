// MARK: - Mocks generated from file: ../DogsClient/Infrastructure/Networking/ApiProtocol.swift at 2022-09-14 14:07:42 +0000

//
//  RestApi.swift
//  DogsClient
//
//  Created by Petru Lutenco on 13.09.2022.
//

import Cuckoo
@testable import DogsClient

import Foundation






 class MockApiProtocol: ApiProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ApiProtocol
    
     typealias Stubbing = __StubbingProxy_ApiProtocol
     typealias Verification = __VerificationProxy_ApiProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ApiProtocol?

     func enableDefaultImplementation(_ stub: ApiProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    
    
    
     required init(networkProvider: NetworkProviderProtocol) {
        
    }
    
    

    
    
    
    
     func get<T: Decodable>(endpoint: Endpoint) async throws -> T {
        
    return try await cuckoo_manager.callThrows(
    """
    get(endpoint: Endpoint) async throws -> T
    """,
            parameters: (endpoint),
            escapingParameters: (endpoint),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: await __defaultImplStub!.get(endpoint: endpoint))
        
    }
    
    

     struct __StubbingProxy_ApiProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func get<M1: Cuckoo.Matchable, T: Decodable>(endpoint: M1) -> Cuckoo.ProtocolStubThrowingFunction<(Endpoint), T> where M1.MatchedType == Endpoint {
            let matchers: [Cuckoo.ParameterMatcher<(Endpoint)>] = [wrap(matchable: endpoint) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockApiProtocol.self, method:
    """
    get(endpoint: Endpoint) async throws -> T
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_ApiProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func get<M1: Cuckoo.Matchable, T: Decodable>(endpoint: M1) -> Cuckoo.__DoNotUse<(Endpoint), T> where M1.MatchedType == Endpoint {
            let matchers: [Cuckoo.ParameterMatcher<(Endpoint)>] = [wrap(matchable: endpoint) { $0 }]
            return cuckoo_manager.verify(
    """
    get(endpoint: Endpoint) async throws -> T
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class ApiProtocolStub: ApiProtocol {
    

    
    
     required init(networkProvider: NetworkProviderProtocol) {
        
    }
    
    

    
    
    
    
     func get<T: Decodable>(endpoint: Endpoint) async throws -> T  {
        return DefaultValueRegistry.defaultValue(for: (T).self)
    }
    
    
}





// MARK: - Mocks generated from file: ../DogsClient/Infrastructure/Networking/NetworkProviderProtocol.swift at 2022-09-14 14:07:42 +0000

//
//  NetworkProvider.swift
//  DogsClient
//
//  Created by Petru Lutenco on 14.09.2022.
//

import Cuckoo
@testable import DogsClient

import Foundation






 class MockNetworkProviderProtocol: NetworkProviderProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = NetworkProviderProtocol
    
     typealias Stubbing = __StubbingProxy_NetworkProviderProtocol
     typealias Verification = __VerificationProxy_NetworkProviderProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: NetworkProviderProtocol?

     func enableDefaultImplementation(_ stub: NetworkProviderProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func data(from: URL) async throws -> (Data, URLResponse) {
        
    return try await cuckoo_manager.callThrows(
    """
    data(from: URL) async throws -> (Data, URLResponse)
    """,
            parameters: (from),
            escapingParameters: (from),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: await __defaultImplStub!.data(from: from))
        
    }
    
    

     struct __StubbingProxy_NetworkProviderProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func data<M1: Cuckoo.Matchable>(from: M1) -> Cuckoo.ProtocolStubThrowingFunction<(URL), (Data, URLResponse)> where M1.MatchedType == URL {
            let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: from) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockNetworkProviderProtocol.self, method:
    """
    data(from: URL) async throws -> (Data, URLResponse)
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_NetworkProviderProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func data<M1: Cuckoo.Matchable>(from: M1) -> Cuckoo.__DoNotUse<(URL), (Data, URLResponse)> where M1.MatchedType == URL {
            let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: from) { $0 }]
            return cuckoo_manager.verify(
    """
    data(from: URL) async throws -> (Data, URLResponse)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class NetworkProviderProtocolStub: NetworkProviderProtocol {
    

    

    
    
    
    
     func data(from: URL) async throws -> (Data, URLResponse)  {
        return DefaultValueRegistry.defaultValue(for: ((Data, URLResponse)).self)
    }
    
    
}





// MARK: - Mocks generated from file: ../DogsClient/Infrastructure/ViewModelProtocol.swift at 2022-09-14 14:07:42 +0000

//
//  ViewModelProtocol.swift
//  DogsClient
//
//  Created by Petru Lutenco on 12.09.2022.
//

import Cuckoo
@testable import DogsClient

import Combine






 class MockViewModelProtocol: ViewModelProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ViewModelProtocol
    
     typealias Stubbing = __StubbingProxy_ViewModelProtocol
     typealias Verification = __VerificationProxy_ViewModelProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: (any ViewModelProtocol)?

     func enableDefaultImplementation(_ stub: any ViewModelProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    

     struct __StubbingProxy_ViewModelProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
    }

     struct __VerificationProxy_ViewModelProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
    }
}


 class ViewModelProtocolStub: ViewModelProtocol {
    

    

    
}




