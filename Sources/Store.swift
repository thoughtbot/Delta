/**
 A protocol that defines storage of an observable state and dispatch methods to
 modify it. Typically you will implement this on a struct and create a shared
 instance that you reference throughout your application to get the state or
 dispatch actions to change it.

 Sample store:

 ```swift
 struct AppState {
     var id = ObservableProperty(0)
 }

 let initialState = AppState()
 var store = Store(state: ObservableProperty(initialState))
 ```

*/
public struct Store<ObservableState: ObservablePropertyType> {

    public typealias StateValueType = ObservableState.ValueType

    /**
     A function type that takes a state value and a `next` and can return either
     false or the result of `next`. It is used to determine whether state will be
     mutated or not when an action is dispatched.
    */
    public typealias Middleware = (StateValueType, () -> Bool) -> Bool

    /**
     A collection of Middleware functions to be performed and when an action
     is dispatched and potentially prevent the state from being updated.
     */
    private var middlewares = [Middleware]()

    /**
     The root state of the application.
    */
    public var state: ObservableState

    public init(state: ObservableState) {
        self.state = state
    }

    /**
     Dispatches an action by settings the state's value to the result of
     calling its `reduce` method.
     */
    public mutating func dispatch<Action: ActionType where Action.StateValueType == ObservableState.ValueType>(action: Action) {
        if wrapMiddleware(middlewares.count - 1, f: { _ in return true })(state.value) {
            state.value = action.reduce(state.value)
        }
    }

    /**
     Dispatch a dynamic action that, when called, should trigger another dispatch
     with a mutating action.
    */
    public func dispatch<DynamicAction: DynamicActionType>(action: DynamicAction) -> DynamicAction.ResponseType {
        return action.call()
    }
}

extension Store {
    /**
     Register a new middleware to be performed when an action is dispatched
     and potentially prevent the state from being updated.
    */
    public mutating func register(middleware: Middleware) {
        middlewares.append(middleware)
    }

    /**
     Check each middleware, executing success if they all return true, or
     failure if any return false.
    */
    private mutating func update<Action: ActionType where Action.StateValueType == ObservableState.ValueType>(action: Action) {
        if wrapMiddleware(middlewares.count - 1, f: { _ in return true })(state.value) {
            state.value = action.reduce(state.value)
        }
    }

    /**
     Recursively wrap middlewares, passing each to the previous as `next`
     so that it may be called and returned as a way to continue.
    */
    private func wrapMiddleware(index: Int, f: (StateValueType) -> Bool) -> (StateValueType) -> Bool {
        if index < 0 {
            return f
        } else {
            return wrapMiddleware(index - 1) { stateValue -> Bool in
                return self.middlewares[0](stateValue) {
                    return f(stateValue)
                }
            }
        }
    }
}
