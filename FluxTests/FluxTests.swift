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
}
