public class Store<State> {
    private typealias ObservableState = ObservableProperty<State>

    private var internalState: ObservableProperty<State>

    public var state:  ObservableProperty<State> {
        return internalState
    }

    public convenience init(state: State) {
      self.init(observableState: ObservableProperty(value: state))
    }

    private init(observableState: ObservableState) {
        self.internalState = observableState
    }

    public func dispatch<A: ActionType where A.State == State>(action: A) {
        self.internalState.value = action.reduce(self.state.value)
    }

    public func dispatch<A: AsyncActionType where A.State == State>(action: A) -> A.State {
        return action.call()
    }
}
