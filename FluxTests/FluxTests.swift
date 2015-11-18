import XCTest
import RxSwift
import Flux

var store: Store!
var disposeBag: DisposeBag!

class FluxTests: XCTestCase {
    override func setUp() {
        super.setUp()
        store = Store(state: AppState())
        disposeBag = DisposeBag()
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
        store.dispatch(action).subscribeNext { next in
            XCTAssertEqual(store.users, usersToReturn)
            expectation.fulfill()
        }.addDisposableTo(disposeBag)

        waitForExpectationsWithTimeout(0.5, handler: nil)
    }

    func testSubscribeState() {
        let expectation = expectationWithDescription("State producer fires event when value within changes")
        let user = User(name: "Test")

        store.state.subscribeNext { _ in
            // This protects for it getting called on initialization with current nil value
            guard let currentUser = store.currentUser else { return }

            XCTAssertEqual(currentUser, user)
            expectation.fulfill()
        }.addDisposableTo(disposeBag)
        store.dispatch(SetCurrentUserAction(user: user))

        waitForExpectationsWithTimeout(0.5, handler: nil)
    }

    func testSubscribeValueWithinState() {
        let expectation = expectationWithDescription("currentUser producer only fires event when it's value changes")
        let user = User(name: "Test")
        let otherUsers = [User(name: "Jane Doe"), User(name: "John Doe")]

        var called = 0
        store.state.value.currentUser.subscribeNext { _ in
            called += 1

            if called > 1 {
                XCTAssertEqual(called, 2, "called initially when bound and after it updated")
                expectation.fulfill()
            }
        }.addDisposableTo(disposeBag)
        store.dispatch(SetCurrentUserAction(user: user))
        store.dispatch(SetUsersAction(users: otherUsers))

        waitForExpectationsWithTimeout(0.5, handler: nil)
    }
}
