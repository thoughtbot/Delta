import Quick
import Nimble
import Delta

var store: Store!

class StoreSpec: QuickSpec {
    override func spec() {
        describe("Store") {
            describe(".dispatch") {
                beforeEach() {
                    let initialState = ObservableProperty(AppState())
                    store = Store(state: initialState)
                }
                
                it("triggers action") {
                    let user = User(name: "Jane Doe")
                    
                    store.dispatch(SetCurrentUserAction(user: user))
                    
                    expect(store.currentUser).to(equal(user))
                }
                
                it("triggers async action") {
                    let usersToReturn = [User(name: "Jane Doe"), User(name: "John Doe")]
                    
                    let action = FetchUsersAction(usersToReturn: usersToReturn)
                    store.dispatch(action)
                    
                    expect(store.users).toEventually(equal(usersToReturn))
                }

                it("handles multiple actions in a row") {
                    let mary = User(name: "Mary", active: false)
                    let john = User(name: "John", active: true)
                    let kate = User(name: "Kate", active: false)
                    let users = [mary, john, kate]

                    store.dispatch(SetUsersAction(users: users))
                    store.dispatch(SetUserActiveAction(user: mary, active: true))
                    store.dispatch(SetUserActiveAction(user: john, active: false))
                    store.dispatch(SetUserActiveAction(user: kate, active: true))

                    expect(store.users).to(equal([
                        User(name: "Mary", active: true),
                        User(name: "John", active: false),
                        User(name: "Kate", active: true),
                    ]))
                }
            }
        }
    }
}
