public protocol ActionType {
    typealias StateValueType
    typealias TheStore: StoreType

    func reduce(state: StateValueType, store: TheStore) -> StateValueType
}
