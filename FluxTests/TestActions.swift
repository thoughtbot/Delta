import ReactiveCocoa
@testable import Flux

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

struct FetchUsersAction: AsyncAction {
    typealias Response = SignalProducer<[User], NoError>
    let usersToReturn: [User]

    func call() -> Response {
        return SignalProducer { observer, _ in
            delay(0.1) {
                store.dispatch(SetUsersAction(users: self.usersToReturn))
                observer.sendNext(self.usersToReturn)
                observer.sendCompleted()
            }
        }
    }
}

