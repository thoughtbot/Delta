public protocol ActionType {
    typealias State
    func reduce(state: State) -> State
}
