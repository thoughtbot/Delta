@testable import Flux

struct AppState {
    let currentUser: ObservableProperty<User?> = ObservableProperty(value: .None)
    let users: ObservableProperty<[User]> = ObservableProperty(value: [])
}
