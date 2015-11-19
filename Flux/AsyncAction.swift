public protocol AsyncAction {
    typealias Response
    func call() -> Response
}
