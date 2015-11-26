# Using Reactive Extensions Frameworks

Delta is built to be pluggable. The driving force for this was so it could be
used with reactive frameworks. This allows you to get the benefits of Delta and the reactive
framework of your choice.

To plug in a framework is as simple as replacing the state of the store with
a custom observable type. The type must implement the `ObservablePropertyType`
protocol.

Here's how that looks with 2 popular reactive implementations. First implementing 
`ObservablePropertyType` then initializing a state and store using it.

## ReactiveCocoa

```swift
import Delta
import ReactiveCocoa

extension MutableProperty: ObservablePropertyType {
  typealias ValueType = Value
}

struct AppState {
  let userId: MutableProperty<Int?>(.None)
}

struct Store: StoreType {
  var state: MutableProperty<AppState>
}

let initialState = AppState()
var store = Store(state: MutableProperty(initialState))

// Subscribe to any change in the app's state
store.state.producer.startWithNext { (newState: AppState) in
  print("new state: \(newState)")
}

// Subscribe to a change in the userId
store.state.value.userId.producer.startWithNext { (newId: Int) in
  print("new id: \(newId)")
}
```

## RxSwift

```swift
import Delta
import RxSwift

extension Variable: ObservablePropertyType {
  typealias ValueType = Element
}

struct AppState {
  let userId: Variable<Int?>(.None)
}

struct Store: StoreType {
  var state: Variable<AppState>
}

let initialState = AppState()
var store = Store(state: Variable(initialState))

// Subscribe to any change in the app's state
store.state.subscribeNext { (newState: AppState) in
  print("new state: \(newState)")
}

// Subscribe to a change in the userId
store.state.value.userId.subscribeNext { (newId: Int) in
  print("new id: \(newId)")
}
```
