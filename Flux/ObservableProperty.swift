public protocol ObservablePropertyType {
    typealias ValueType
    var value: ValueType { get set }
}

public class ObservableProperty<ValueType> {
    public typealias CallbackType = (ValueType -> ())
    private var _value: ValueType
    private var subscriptions = [CallbackType]()

    public var value: ValueType {
        get {
            return self._value
        }
        set {
            self._value = newValue
            notifySubscriptions()
        }
    }

    public init(value: ValueType) {
        self._value = value
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
