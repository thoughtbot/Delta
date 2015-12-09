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

 struct Store: StoreType {
     var state: ObservableProperty<AppState>
 }

 let initialState = AppState()
 var store = Store(state: ObservableProperty(initialState))
 ```
*/
public protocol Store {
    /**
     An observable state of the store. This is accessed directly to subscribe to
     changes.
    */
    typealias ObservableState: Observable

    /**
     The type of the root state of the application.

     - note: This is inferred from the `reduce` method implementation.
    */
    var state: ObservableState { get set }

    /**
     Dispatch an action that will mutate the state of the store.
    */
    mutating func dispatch<A: Action where A.StateValueType == ObservableState.ValueType>(action: A)

    /**
     Dispatch an async action that when called should trigger another dispatch
     with a synchronous action.
    */
    func dispatch<D: DynamicAction>(action: D) -> D.ResponseType
}

public extension Store {
    /**
      Dispatches an action by settings the state's value to the result of
      calling it's `reduce` method.
    */
    public mutating func dispatch<A: Action where A.StateValueType == ObservableState.ValueType>(action: A) {
        state.value = action.reduce(state.value)
    }

    /**
      Dispatches an async action by calling it's `call` method.
    */
    public func dispatch<D: DynamicAction>(action: D) -> D.ResponseType {
        return action.call()
    }
}
