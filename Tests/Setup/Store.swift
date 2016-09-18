import Delta

struct AppState {
    let currentUser = ObservableProperty<User?>(.none)
    let users = ObservableProperty<[User]>([])
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
