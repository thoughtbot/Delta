import Delta

struct AppState {
    let currentUser = ObservableProperty<User?>(.None)
    let users = ObservableProperty<[User]>([])
}

struct Store: StoreType {
    var state: ObservableProperty<AppState>
    var middlewares = MiddlewareContainer()

    init(state: ObservableProperty<AppState>) {
        self.state = state
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