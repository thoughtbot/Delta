import Quick
import Nimble
import Flux

var store: Store!

class StoreTests: QuickSpec {
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
            }
        }
    }
}
