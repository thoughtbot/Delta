struct User {
    let name: String
    let active: Bool

    init(name: String, active: Bool = false) {
        self.name = name
        self.active = active
    }
}

extension User: Equatable { }

func == (lhs: User, rhs: User) -> Bool {
    return lhs.name == rhs.name && lhs.active == rhs.active
}
