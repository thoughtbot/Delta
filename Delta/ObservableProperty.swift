public protocol ObservablePropertyType {
    typealias ValueType
    var value: ValueType { get set }
}

public class ObservableProperty<ValueType> {
    public typealias CallbackType = (ValueType -> ())

    private var subscriptions = [CallbackType]()

    public var value: ValueType {
        didSet {
            notifySubscriptions()
        }
    }

    public init(_ value: ValueType) {
        self.value = value
    }

    public func subscribe(callback: CallbackType) {
        subscriptions.append(callback)
    }

    private func notifySubscriptions() {
        for subscription in subscriptions {
            subscription(value)
        }
    }
}

extension ObservableProperty: ObservablePropertyType { }
