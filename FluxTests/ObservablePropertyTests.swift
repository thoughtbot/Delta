import XCTest
import Flux

class ObservablePropertyTests: XCTestCase {
    func testInitializeWithValue() {
        let value = 1

        let property = ObservableProperty(value: value)

        XCTAssertEqual(property.value, value)
    }

    func testSubscriptionsCalled() {
        let property = ObservableProperty(value: 1)

        var called = 0
        property.subscribe { _ in called++ }
        property.subscribe { _ in called++ }
        property.value = 5

        XCTAssertEqual(called, 2)
    }
}
