import Delta

struct SetCurrentUserAction: Action {
    let user: User

    func reduce(state: AppState) -> AppState {
        state.currentUser.value = user
        return state
    }
}

struct SetUsersAction: Action {
    let users: [User]

    func reduce(state: AppState) -> AppState {
        state.users.value = users
        return state
    }
}

struct FetchUsersAction: DynamicAction {
    typealias ResponseType = Void

    let usersToReturn: [User]

    func call() {
        delay(0.1) {
            store.dispatch(SetUsersAction(users: self.usersToReturn))
        }
    }
}
