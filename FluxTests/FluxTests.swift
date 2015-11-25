import XCTest
import Flux

var store: Store!

class FluxTests: XCTestCase {
    override func setUp() {
        super.setUp()
        let initialState = ObservableProperty(value: AppState())
        store = Store(state: initialState)
    }

    func testDispatchAction() {
        let user = User(name: "Jane Doe")

        store.dispatch(SetCurrentUserAction(user: user))

        XCTAssertEqual(store.currentUser, user)
    }

    func testDispatchAsyncAction() {
        let expectation = expectationWithDescription("dispatch completed")
        let usersToReturn = [User(name: "Jane Doe"), User(name: "John Doe")]

        store.state.subscribe { _ in
            XCTAssertEqual(store.users, usersToReturn)
            expectation.fulfill()
        }
        let action = FetchUsersAction(usersToReturn: usersToReturn)
        store.dispatch(action)

        waitForExpectationsWithTimeout(0.5, handler: nil)
    }
}
