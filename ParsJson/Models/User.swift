
struct User: Decodable {
    let id: Int
    let password: String
    let first_name: String
    let last_name: String
    let username: String
    let email: String
    let avatar: String
    
    var describe: String {
        """
        Id: \(id)
        password: \(password)
        first name: \(first_name)
        last name: \(last_name)
        username: \(username)
        email: \(email)
        """
    }
    
    init(id: Int, password: String, first_name: String, last_name: String, username: String, email: String, avatar: String) {
        self.id = id
        self.password = password
        self.first_name = first_name
        self.last_name = last_name
        self.username = username
        self.email = email
        self.avatar = avatar
    }
    
    init(userData: [String: Any]) {
        id = userData["id"] as? Int ?? 0
        password = userData["password"] as? String ?? ""
        first_name = userData["first_name"] as? String ?? ""
        last_name = userData["last_name"] as? String ?? ""
        username = userData["username"] as? String ?? ""
        email = userData["email"] as? String ?? ""
        avatar = userData["avatar"] as? String ?? ""
    }
    
    static func getUsers(from value: Any) -> [User] {
        guard let usersData = value as? [[String: Any]] else { return []}
        var users = [User]()
        
        return usersData.compactMap { User(userData: $0)
        }
        
//        return usersData.compactMap { userData in
//            User(userData: userData)
//        }
        
        
//        for userData in usersData {
//            let user = User(userData: userData)
//            users.append(user)
////        }
//        return users
    }
}


