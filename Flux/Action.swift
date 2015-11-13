public protocol FluxAction {
    typealias StateT
    func reduce(state: StateT) -> StateT
}
