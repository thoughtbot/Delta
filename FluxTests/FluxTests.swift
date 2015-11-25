import XCTest
import Flux

var store: Store<AppState>!

class FluxTests: XCTestCase {
    override func setUp() {
        super.setUp()
        store = Store(state: AppState())
    }

    func testDispatchAction() {
        let user = User(name: "Jane Doe")

        store.dispatch(SetCurrentUserAction(user: user))

        XCTAssertEqual(store.state.value.currentUser.value, user)
    }

//    func testDispatchAsyncAction() {
//        let expectation = expectationWithDescription("dispatch completed")
//        let usersToReturn = [User(name: "Jane Doe"), User(name: "John Doe")]
//
//        store.state.value.users.subscribe { users in
//            XCTAssertEqual(users, usersToReturn)
//            expectation.fulfill()
//        }
//
//        let action = FetchUsersAction(usersToReturn: usersToReturn)
//        store.dispatch(action)
//
//        waitForExpectationsWithTimeout(0.5, handler: nil)
//    }
}
