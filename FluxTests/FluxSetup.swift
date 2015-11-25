@testable import Flux

struct AppState {
    let currentUser: ObservableProperty<User?> = ObservableProperty(value: .None)
    let users: ObservableProperty<[User]> = ObservableProperty(value: [])
}

struct Store: StoreType {
    var state: ObservableProperty<AppState>
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
