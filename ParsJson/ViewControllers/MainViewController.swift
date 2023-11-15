
import UIKit


enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}

final class MainViewController: UIViewController {
    
    private var users = [User]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUsers" {
            guard let usersTVC = segue.destination as? UsersTableViewController else { return }
            usersTVC.fetchUsers()
        }
    }
    
}

