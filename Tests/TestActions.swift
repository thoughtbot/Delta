import Delta

struct SetCurrentUserAction: ActionType {
    let user: User

    func reduce(state: AppState, store: Store) -> AppState {
        state.currentUser.value = user
        return state
    }
}

struct SetUsersAction: ActionType {
    let users: [User]

    func reduce(state: AppState, store: Store) -> AppState {
        state.users.value = users
        return state
    }

}

struct FetchUsersAction: DynamicActionType {
    let usersToReturn: [User]

    func call(var store: Store) {
        delay(0.1) {
            store.dispatch(SetUsersAction(users: self.usersToReturn))
        }
    }
}
