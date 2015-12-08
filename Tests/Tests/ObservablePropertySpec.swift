import Quick
import Nimble
import Delta

class ObservablePropertySpec: QuickSpec {
    override func spec() {
        describe("ObservableProperty") {
            it("is initialized with a value") {
                let property = ObservableProperty(1)
                
                expect(property.value).to(equal(1))
            }
            
            describe("subscriptions") {
                it("calls subscriptions when value changes") {
                    let property = ObservableProperty(1)
                    
                    var called = 0
                    property.subscribe { _ in called++ }
                    property.subscribe { _ in called++ }
                    property.value = 5

                    expect(called).to(equal(2))
                }
            }
        }
    }
}
