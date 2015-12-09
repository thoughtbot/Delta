import Delta

struct AppState {
    let currentUser = ObservableProperty<User?>(.None)
    let users = ObservableProperty<[User]>([])
}

// MARK: Getters
extension Store where ObservableState.ValueType == AppState {
    var currentUser: User? {
        return state.value.currentUser.value
    }

    var users: [User] {
        return state.value.users.value
    }
}
