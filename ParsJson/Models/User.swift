
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
}


