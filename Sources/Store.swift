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
public protocol StoreType {
    /**
     An observable state of the store. This is accessed directly to subscribe to
     changes.
    */
    associatedtype ObservableState: ObservablePropertyType

    /**
     The type of the root state of the application.

     - note: This is inferred from the `reduce` method implementation.
    */
    var state: ObservableState { get set }

    /**
     Dispatch an action that will mutate the state of the store.
    */
    mutating func dispatch<Action: ActionType>(_ action: Action) where Action.StateValueType == ObservableState.ValueType

    /**
     Dispatch an async action that when called should trigger another dispatch
     with a synchronous action.
    */
    func dispatch<DynamicAction: DynamicActionType>(_ action: DynamicAction) -> DynamicAction.ResponseType
}

public extension StoreType {
    /**
      Dispatches an action by settings the state's value to the result of
      calling it's `reduce` method.
    */
    public mutating func dispatch<Action: ActionType>(_ action: Action) where Action.StateValueType == ObservableState.ValueType {
        state.value = action.reduce(state: state.value)
    }

    /**
      Dispatches an async action by calling it's `call` method.
    */
    public func dispatch<DynamicAction: DynamicActionType>(_ action: DynamicAction) -> DynamicAction.ResponseType {
        return action.call()
    }
}
