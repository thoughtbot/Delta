protocol FluxAsyncAction {
    typealias Response
    func call() -> Response
}
