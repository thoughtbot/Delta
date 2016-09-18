/**
 This protocol is used when you want to make modifications to the store's state.
 All changes to the store go through this type.

 Sample Action:

 ```swift
 struct UpdateIdAction: ActionType {
     let id: Int

     func reduce(state: AppState) -> AppState {
         state.id.value = id
         return state
     }
 }

 store.dispatch(UpdateIdAction(id: 1))
 ```
*/
public protocol ActionType {
    /**
     The type of the app's state.

     - note: This is inferred from the `reduce` method implementation.
    */
    associatedtype StateValueType

    /**
     This method is called when this action is dispatched. Its purpose is to
     make modifications to the state and return a new version of it.

     - note: This is the only place that changes to the state are permitted.
     - parameter state: The current state of the store.
     - returns: The new state.
    */
    func reduce(state: StateValueType) -> StateValueType
}
