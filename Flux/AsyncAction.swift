public protocol AsyncActionType {
    typealias State
    func call() -> State
}
