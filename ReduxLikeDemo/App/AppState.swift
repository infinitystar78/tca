//
//  AppState.swift
//  ReduxLikeDemo
//
//  Created by M W on 09/11/2022.
//

import Foundation
import Combine


typealias Reducer<State, Action, Environment> = (inout State, Action, Environment) -> AnyPublisher <Action, Never>?
typealias AppStore = Store<AppState, AppAction, Global>


struct Global {
    var service = NetworkService()
}


struct AppState {
    var searchResult: [Recipe] = []
}

enum AppAction {
    case search(query: String)
    case setResults(results: [Recipe])
    
}


func appReducer(state: inout AppState, action: AppAction, environment: Global) -> AnyPublisher<AppAction, Never>{
    switch action {
    case let .setResults(results):
        state.searchResult = results
    case let .search(query):
        return environment.service
            .searchPublisher(matching: query)
            .replaceError(with: [])
            .map { AppAction.setSearchResults(repos: $0) }
            .eraseToAnyPublisher()
        break
    }
    
    return Empty().eraseToAnyPublisher()
}



final class Store <State, Action, Environment>: ObservableObject {
    @Published private(set) var state: State
    private let environment: Environment
    private let reducer: Reducer<State, Action, Environment>
    private var effectCancellables: Set<AnyCancellable> = []
    
    init(
        initialState: State,
        reducer: @escaping Reducer<State, Action, Environment>,
        environment: Environment) {
        self.state = initialState
        self.reducer = reducer
        self.environment = environment
    }
// search function
    func search(_ action: Action) {
        guard let effect = reducer(&state, action, environment)  else {
            return
        }
        
        effect.receive(on: DispatchQueue.main)
              .sink(receiveValue: search)
              .store(in: &effectCancellables)
        
    }
    
}








