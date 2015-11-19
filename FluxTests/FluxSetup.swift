@testable import Flux

struct AppState {
    let currentUser: ObservableProperty<User?> = ObservableProperty(value: .None)
    let users: ObservableProperty<[User]> = ObservableProperty(value: [])
}

protocol Action: ActionType {
    typealias StateValueType = AppState
}

protocol AsyncAction: AsyncActionType { }

class Store: Flux.Store<ObservableProperty<AppState>> {
    init(state: AppState) {
        super.init(state: ObservableProperty(value: state))
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
