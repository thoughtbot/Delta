public class Store<StateT: ObservableState> {
    public var state: StateT

    public init(state: StateT) {
        self.state = state
    }

    public func dispatch<A: Action where A.StateValueT == StateT.Value>(action: A) {
        self.state.value = action.reduce(self.state.value)
    }

    public func dispatch<A: AsyncAction>(action: A) -> A.Response {
        return action.call()
    }
}
