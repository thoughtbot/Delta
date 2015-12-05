public protocol MiddlewareType {
    func call<Action: ActionType>(action: Action) -> Action?
    func call<Action: ActionType, DynamicAction: DynamicActionType>(action: Action) -> DynamicAction?
    func call<DynamicAction: DynamicActionType>(action: DynamicAction) -> DynamicAction?
    func call<DynamicAction: DynamicActionType, Action: ActionType>(action: DynamicAction) -> Action?
}

struct DynamicWrapperAction<Action: ActionType>: DynamicActionType {
    let action: Action

    func call() {
        print("I SHOULD PROBABLY DISPATCH \(action)")
    }
}

extension MiddlewareType {
    func call<Action: ActionType, DynamicAction: DynamicActionType>(action: Action) -> DynamicAction? {
        return DynamicWrapperAction(action: action) as? DynamicAction
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
        return middlewares.reduce(action) { (x, middleware) in
            return middleware.call(x) ?? x
        }
    }
}