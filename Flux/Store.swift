public class Store<ObservableState: ObservablePropertyType> {
    public var state: ObservableState

    public init(state: ObservableState) {
        self.state = state
    }

    public func dispatch<A: ActionType where A.StateValueType == ObservableState.ValueType>(action: A) {
        self.state.value = action.reduce(self.state.value)
    }

    public func dispatch<A: AsyncActionType>(action: A) -> A.ResponseType {
        return action.call()
    }
}
