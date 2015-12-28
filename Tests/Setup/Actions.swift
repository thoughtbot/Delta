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

struct SetUserActiveAction: ActionType {
    let user: User
    let active: Bool

    func reduce(state: AppState) -> AppState {
        state.users.value = state.users.value.map { u in
            if u == user {
                return User(name: u.name, active: active)
            }

            return u
        }
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
