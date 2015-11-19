public protocol AsyncActionType {
    typealias ResponseType
    func call() -> ResponseType
}
