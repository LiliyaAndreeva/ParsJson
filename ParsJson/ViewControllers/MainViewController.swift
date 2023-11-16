
import UIKit

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

