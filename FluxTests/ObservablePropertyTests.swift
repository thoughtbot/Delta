import Quick
import Nimble
import Flux

class ObservablePropertyTests: QuickSpec {
    override func spec() {
        describe("ObservableProperty") {
            it("is initialized with a value") {
                let value = 1
                
                let property = ObservableProperty(value: value)
                
                expect(property.value).to(equal(value))
            }
            
            describe("subscriptions") {
                it("calls subscriptions when value changes") {
                    let property = ObservableProperty(value: 1)
                    
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
