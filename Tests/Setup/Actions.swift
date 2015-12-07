import Delta

struct SetCurrentUserAction: ActionType {
    let user: User

    func reduce(state: AppState) -> AppState {
        state.currentUser.value = user
        return state
    }
}

struct SetUsersAction: ActionType {
    let users: [User]

    func reduce(state: AppState) -> AppState {
        state.users.value = users
        return state
    }
}

struct FetchUsersAction: DynamicActionType {
    typealias ResponseType = Void

    let usersToReturn: [User]

    func call() {
        delay(0.1) {
            store.dispatch(SetUsersAction(users: self.usersToReturn))
        }
    }
}
