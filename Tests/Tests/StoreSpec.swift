import Quick
import Nimble
import Delta

var store: Store<ObservableProperty<AppState>>!

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

                it("executes middleware") {
                    var executed = false

                    store.register { state, next -> Bool in
                        executed = true

                        return next()
                    }

                    let user = User(name: "Jane Doe")
                    let action = SetCurrentUserAction(user: user)
                    store.dispatch(action)

                    expect(store.state.value.currentUser.value).to(equal(user))
                    expect(executed).to(beTrue())
                }
            }
        }
    }
}
