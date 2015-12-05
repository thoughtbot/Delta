public protocol ActionType {
    typealias StateValueType
    func reduce(state: StateValueType) -> StateValueType
}
