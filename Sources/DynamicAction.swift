public protocol DynamicActionType {
    typealias ResponseType
    typealias TheStore: StoreType

    func call(store: TheStore) -> ResponseType
}
