struct User {
    let name: String
}

extension User: Equatable { }

func == (lhs: User, rhs: User) -> Bool {
    return lhs.name == rhs.name
}
