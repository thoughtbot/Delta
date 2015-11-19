import RxSwift
@testable import Flux

struct AppState {
    let currentUser: Variable<User?> = Variable(.None)
    let users: Variable<[User]> = Variable([])
}

typealias VariableAppState = Variable<AppState>

protocol Action: Flux.Action {
    typealias StateT = VariableAppState
}

protocol AsyncAction: Flux.AsyncAction { }

extension Variable: Flux.ObservableState {
    public typealias Value = Element
}

class Store: Flux.Store<VariableAppState> {
    init(state: AppState) {
        super.init(state: VariableAppState(state))
    }
}

// MARK: Getters
extension Store {
    var currentUser: User? {
        return state.value.currentUser.value
    }

    var users: [User] {
        return state.value.users.value
    }
}
