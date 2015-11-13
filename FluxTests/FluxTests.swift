import XCTest
@testable import Flux

var store: Store!

class FluxTests: XCTestCase {
    override func setUp() {
        super.setUp()
        store = Store(state: AppState())
    }

    func testDispatchAction() {
        let user = User(name: "Jane Doe")

        store.dispatch(SetCurrentUserAction(user: user))

        XCTAssertEqual(store.currentUser, user)
    }

    func testDispatchAsyncAction() {
        let expectation = expectationWithDescription("dispatch completed")
        let usersToReturn = [User(name: "Jane Doe"), User(name: "John Doe")]

        let action = FetchUsersAction(usersToReturn: usersToReturn)
        store.dispatch(action).startWithNext { _ in
            XCTAssertEqual(store.users, usersToReturn)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(0.5, handler: nil)
    }

    func testSubscribeState() {
        let expectation = expectationWithDescription("State producer fires event when value within changes")
        let user = User(name: "Test")

        store.state.producer.startWithNext { _ in
            // This protects for it getting called on initialization with current nil value
            guard let currentUser = store.currentUser else { return }

            XCTAssertEqual(currentUser, user)
            expectation.fulfill()
        }
        store.dispatch(SetCurrentUserAction(user: user))

        waitForExpectationsWithTimeout(0.5, handler: nil)
    }

    func testSubscribeValueWithinState() {
        let expectation = expectationWithDescription("currentUser producer only fires event when it's value changes")
        let user = User(name: "Test")
        let otherUsers = [User(name: "Jane Doe"), User(name: "John Doe")]

        var called = 0
        store.state.value.currentUser.producer.on(next: { _ in
            called += 1
        }).startWithNext { _ in
            if called > 1 {
                XCTAssertEqual(called, 2, "called initially when bound and after it updated")
                expectation.fulfill()
            }
        }
        store.dispatch(SetCurrentUserAction(user: user))
        store.dispatch(SetUsersAction(users: otherUsers))

        waitForExpectationsWithTimeout(0.5, handler: nil)
    }
}
