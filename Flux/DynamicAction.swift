public protocol DynamicActionType {
    typealias ResponseType
    func call() -> ResponseType
}
