public protocol StoreType {
    typealias ObservableState: ObservablePropertyType

    var state: ObservableState { get set }

    mutating func dispatch<Action: ActionType where Action.StateValueType == ObservableState.ValueType, Action.TheStore == Self>(action: Action)
    func dispatch<DynamicAction: DynamicActionType where DynamicAction.TheStore == Self>(action: DynamicAction) -> DynamicAction.ResponseType
}

public extension StoreType {
    public mutating func dispatch<Action: ActionType where Action.StateValueType == ObservableState.ValueType, Action.TheStore == Self>(action: Action) {
        state.value = action.reduce(state.value, store: self)
    }

    public func dispatch<DynamicAction: DynamicActionType where DynamicAction.TheStore == Self>(action: DynamicAction) -> DynamicAction.ResponseType {
        return action.call(self)
    }
}