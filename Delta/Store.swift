public protocol StoreType {
    typealias ObservableState: ObservablePropertyType

    var state: ObservableState { get set }

    mutating func dispatch<Action: ActionType where Action.StateValueType == ObservableState.ValueType>(action: Action)
    func dispatch<DynamicAction: DynamicActionType>(action: DynamicAction) -> DynamicAction.ResponseType
}

public extension StoreType {
    public mutating func dispatch<Action: ActionType where Action.StateValueType == ObservableState.ValueType>(action: Action) {
        state.value = action.reduce(state.value)
    }

    public func dispatch<DynamicAction: DynamicActionType>(action: DynamicAction) -> DynamicAction.ResponseType {
        return action.call()
    }
}
