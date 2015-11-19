public protocol Action {
    typealias StateValueT
    func reduce(state: StateValueT) -> StateValueT
}
