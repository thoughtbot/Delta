import ReactiveCocoa

public class FluxStore<StateT: FluxState> {
    public let state: MutableProperty<StateT>

    public init(state: StateT) {
        self.state = MutableProperty(state)
    }

    public func dispatch<A: FluxAction where A.StateT == StateT>(action: A) {
        self.state.value = action.reduce(self.state.value)
    }

    public func dispatch<A: FluxAsyncAction>(action: A) -> A.Response {
        return action.call()
    }
}

struct XState: FluxState { }
let x = FluxStore<XState>(state: XState())
