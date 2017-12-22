/**
 This is the protocol that the state the store holds must implement.

 To use a custom state type, this protocol must be implemented on that object.

 This is useful if you want to plug in a reactive programming library and use
 that for state instead of the built-in ObservableProperty type.
*/
public protocol ObservablePropertyType {
    /**
     The type of the value that `Self` will hold.

     - note: This is inferred from the `value` property implementation.
    */
    associatedtype ValueType

    /**
     The value to be observed and mutated.
    */
    var value: ValueType { get set }
}

/**
 A basic implementation of a property whose `value` can be observed
 using callbacks.


 ```swift
 Example:

 var property = ObservableProperty(1)

 property.subscribe { newValue in
     print("newValue: \(newValue)")
 }

 property.value = 2

 // Executing the above code prints:
 // "newValue: 2"
 ```
*/
public class ObservableProperty<ValueType> {
    /**
     The type of the callback to be called when the `value` changes.
    */
    public typealias CallbackType = ((ValueType) -> ())

    private var subscriptions = [CallbackType]()

    /**
      The `value` stored in this instance. Setting it to a new value will notify
      any subscriptions registered through the `subscribe` method.
    */
    public var value: ValueType {
        didSet {
            notifySubscriptions()
        }
    }

    /**
      - parameter value: The initial value to store.
    */
    public init(_ value: ValueType) {
        self.value = value
    }

    /**
      Register a subscriber that will be called with the new value when the `value` changes.

      - parameter callback: The function to call when the value changes.
    */
    public func subscribe(callback: @escaping CallbackType) {
        subscriptions.append(callback)
    }

    private func notifySubscriptions() {
        for subscription in subscriptions {
            subscription(value)
        }
    }
}

extension ObservableProperty: ObservablePropertyType { }
