public protocol ObservableState {
    typealias Value
    var value: Value { get set }
}
