public protocol StoreType {
    typealias ObservableState: ObservablePropertyType

    var state: ObservableState { get set }

    mutating func dispatch<A: ActionType where A.StateValueType == ObservableState.ValueType>(action: A)
    func dispatch<A: AsyncActionType>(action: A) -> A.ResponseType
}

public extension StoreType {
    public mutating func dispatch<A: ActionType where A.StateValueType == ObservableState.ValueType>(action: A) {
        state.value = action.reduce(state.value)
    }

    public func dispatch<A : AsyncActionType>(action: A) -> A.ResponseType {
        return action.call()
    }
}
