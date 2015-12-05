import Quick
import Nimble
import Delta

var emptyMiddlewareCalled = 0

struct LoggingWrapperAction<Actionx: ActionType>: DynamicActionType {
    let action: Actionx

    func call() {
        print("BEFORE DISPATCH")
        store.dispatch(action)
        print("AFTER DISPATCH")
    }
}

struct EmptyMiddleware: MiddlewareType {
    func call<Action: ActionType>(action: Action) -> Action? {
        emptyMiddlewareCalled += 1
        return action as Action?
    }
}

struct LoggingMiddleware: MiddlewareType {
    func call<Action: ActionType>(action: Action) -> Action? {
        let x = LoggingWrapperAction(action: action)
        return x as Action?
    }
}

class MiddlewareTests: QuickSpec {
    override func spec() {
        describe("Middleware") {
            beforeEach {
                let initialState = ObservableProperty(AppState())
                store = Store(state: initialState)
                emptyMiddlewareCalled = 0
            }

            it("can be registered") {
                store.middlewares.register(EmptyMiddleware())

                expect(store.middlewares.count).to(equal(1))
            }

            it("is called when an action is dispatched") {
                store.middlewares.register(EmptyMiddleware())
                store.middlewares.register(LoggingMiddleware())

                store.dispatch(SetCurrentUserAction(user: User(name: "Jane Doe")))

                expect(emptyMiddlewareCalled).to(equal(1))
            }

            pending("can stop an action from happening") { }
            pending("calls multiple middlewares in the order they were registered") { }
        }
    }
}