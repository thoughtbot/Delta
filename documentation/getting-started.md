# Getting Started

The main idea is that we have a singular place that holds the "app state", "the
store", and we can dispatch "actions" that update that state. Using the
[observer pattern], we can easily subscribe to changes in the state to update
the UI, run background tasks, etc.

Let's begin learning about the concepts by walking through how we'll set up an
app to use it.

[observer pattern]: https://en.wikipedia.org/wiki/Observer_pattern

### The State

First we need to define what your app state is. The properties will need to
mutable so that we can mutate this when we dispatch actions. We do this by
defining a `struct` that stores a user id.

```swift
struct AppState {
  var userId: Int? = .None
}
```

Earlier I mentioned "subscribing" to changes. With this implementation we'll
only be able to subscribe to when _anything_ in the store changes. While in this
example that's fine, in the real world we want to be able to subscribe to
changes in specific values. We can add that functionality by using the
provided `ObservableProperty` type.

```swift
import Delta

struct AppState {
  let userId = ObservableProperty<Int?>(.None)
}
```

One small change is that we're now able to mark the property as `let` instead of
`var`. This is because `ObservableProperty` stores it's value internally which
allows us to mutate it while having the same instance stored in the state.

We'll soon see how to use this new power.

### The Store

Next up we need to define our "store". This is the core of this library
and it's what you'll be using to access the state and dispatch actions to mutate
it.

We'll also define it as a `struct` that implements the `StoreType` protocol.
This protocol provides all the functionality of the store you need.

```swift
import Delta

struct Store: StoreType {
  var state: ObservableProperty<AppState>
}
```

Notice how we also wrap `state` in the `ObservableProperty` class. As mentioned
earlier, this class is what provides the ability to subscribe to changes.

Note: The state can be any object that conforms to the `ObservablePropertyType`
protocol. Implementing that protocol on a different object is how you can plug
in a custom reactive framework implementation. For more information on this, see [the docs on
reactive extensions](./reactive-extensions.md)

Now we need to create an instance of our store and give it it's initial
state.

```swift
let initialState = AppState()
var store = Store(state: ObservableProperty(initialState))
```

We _must_ define the store as a `var` because once we start dispatching actions,
they will be mutating it and the compiler will throw a cryptic error if it's not
a `var`.  At this point you'll probably see a warning that it's not mutated but
we can ignore that for now. Once we start dispatching actions, that will go
away.

While we still don't have a way to modify it, let's take a second to see how
subscriptions work:

```swift
// Subscribe to any change in the app's state
store.state.subscribe { (newState: AppState) in
  print("new state: \(newState)")
}

// Subscribe to a change in the userId
store.state.value.userId.subscribe { (newId: Int?) in
  print("new id: \(newId)")
}

// Update the state
store.dispatch(SetUserIdAction(id: 5))
```

Assuming `SetUserIdAction` is defined and does what it says it does, running
this code we should see an output of:

```
new state: AppState(userId: 5)
new id: 5
```

Let's learn how to implement that action.

### Actions

Actions are how we change the application state. Because all changes go through
an action, it's very easy to see where state is changing within your
app by searching for where all places that actions are dispatched.

There are two types of actions `ActionType` and `DynamicActionType`. 

An action's job is to make synchronous modifications to the store. Its
implementation and `reduce` method should be [pure][pure function], meaning that
given the same inputs, it should produce the same output.

[pure function]: https://en.wikipedia.org/wiki/Pure_function

A dynamic action's job is to do some work and then dispatch regular actions to
make the store modifications. A dynamic action is typically used to do
asynchronous work or group multiple actions under one name.

Let's define one of each.

First, the action:

```swift
struct SetUserIdAction: ActionType {
  let id: Int

  func reduce(state: AppState) -> AppState {
    state.userId.value = id

    return state
  }
}
```

The protocol requires us to implement the `reduce` method we see above. Its job
is to directly modify the state and return a new one. The `.value` is there
because we have to reach into the `ObservableProperty` to get the value.

If we wanted to see this in action, we just have to dispatch it through the
store.

```swift
store.dispatch(SetUserIdAction(id: 5))
```

Now let's pretend that we needed to get the user id from the server and set it.

To do this we implement an async behavior and then dispatch the synchronous one we
wrote when it's complete.

```swift
struct GetUserIdAction: DynamicActionType {
  func call() {
    getUserIdFromSomeApi() { id in
      store.dispatch(SetUserIdAction(id: id))
    }
  }
}
```

It is dispatched the same way as before:

```swift
store.dispatch(GetUserIdAction())
```

The `DynamicActionType` protocol requires you to define the `call` method. It can
optionally return a value of your choosing. This allows you to return the status
of some async action via a `Promise`, `SignalProducer`, `Observer`, etc and
chain off it whatever you need.

### Summary

By combining the state, store and actions we get a powerful system for managing
state and subscribing to changes across our app as needed.
