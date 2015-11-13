import ReactiveCocoa
@testable import Flux

struct AppState: FluxState {
    let currentUser: MutableProperty<User?> = MutableProperty(.None)
    let users: MutableProperty<[User]> = MutableProperty([])
}

protocol Action: FluxAction {
    typealias StateT = AppState
}

protocol AsyncAction: FluxAsyncAction { }

class Store: FluxStore<AppState> {
    override init(state: AppState) {
        super.init(state: state)
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
