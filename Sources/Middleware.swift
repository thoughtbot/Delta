public protocol MiddlewareType {
    func call<Action: ActionType>(action: Action) -> Action?
}

public extension MiddlewareType {
    func call<Action: ActionType>(action: Action) -> Action? {
        return action
    }
}

public class MiddlewareContainer {
    private var middlewares = [MiddlewareType]()

    public var count: Int {
        return middlewares.count
    }

    public init() { }

    public func register(middleware: MiddlewareType) {
        middlewares.append(middleware)
    }

    func call<Action: ActionType>(action: Action) -> Action? {
        return middlewares.reduce(Optional(action)) { (action, middleware) in
            guard let action = action else { return .None }

            return middleware.call(action)
        }
    }
}