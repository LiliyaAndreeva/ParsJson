//
//  UsersTableViewController.swift
//  ParsJson
//
//  Created by Лилия Андреева on 15.11.2023.
//

import UIKit

final class UsersTableViewController: UITableViewController {
    
    
    private let networkManager = NetworkingManager.shared
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            print("Error cast")
            return }
        let user = users[indexPath.row]
        let detailVC = segue.destination as? DetailViewController
        detailVC?.user = user
        print("Succes cast")
    }
}

extension UsersTableViewController {
    func fetchUsers() {
        networkManager.fetchUsers([User].self, from: Link.userUrl.url) { [unowned self] result in
            switch result{
                
            case .success(let dataUsers):
                users = dataUsers
            case .failure(let error):
                print("Error in fetchUsers: \(error)")
            }
            //DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}



    // MARK: - Table view data source
extension UsersTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: users[indexPath.row])
        
        return cell
    }
}
   


