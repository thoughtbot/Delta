import ReactiveCocoa

class FluxStore<StateT: FluxState> {
    let state: MutableProperty<StateT>

    init(state: StateT) {
        self.state = MutableProperty(state)
    }

    func dispatch<A: FluxAction where A.StateT == StateT>(action: A) {
        self.state.value = action.reduce(self.state.value)
    }

    func dispatch<A: FluxAsyncAction>(action: A) -> A.Response {
        return action.call()
    }
}
