public protocol ActionType {
    typealias StateValueType
    typealias Store: StoreType

    func reduce(state: StateValueType, store: Store) -> StateValueType
}

public protocol DynamicActionType {
    typealias ResponseType
    typealias Store: StoreType

    func call(store: Store) -> ResponseType
}

public protocol StoreType {
    typealias ObservableState: ObservablePropertyType

    var state: ObservableState { get set }
    var middlewares: MiddlewareContainer { get }

    mutating func dispatch<Action: ActionType where Action.StateValueType == ObservableState.ValueType, Action.Store == Self>(action: Action)
    func dispatch<DynamicAction: DynamicActionType where DynamicAction.Store == Self>(action: DynamicAction) -> DynamicAction.ResponseType
}

public extension StoreType {
    public mutating func dispatch<Action: ActionType where Action.StateValueType == ObservableState.ValueType, Action.Store == Self>(action: Action) {
        if let x = middlewares.call(action) {
            state.value = x.reduce(state.value, store: self)
        }
    }

    public func dispatch<DynamicAction: DynamicActionType where DynamicAction.Store == Self>(action: DynamicAction) -> DynamicAction.ResponseType {
        return action.call(self)
    }
}

