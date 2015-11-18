import RxSwift

public class FluxStore<StateT: FluxState> {
    public let state: Variable<StateT>

    public init(state: StateT) {
        self.state = Variable(state)
    }

    public func dispatch<A: FluxAction where A.StateT == StateT>(action: A) {
        self.state.value = action.reduce(self.state.value)
    }

    public func dispatch<A: FluxAsyncAction>(action: A) -> A.Response {
        return action.call()
    }
}
