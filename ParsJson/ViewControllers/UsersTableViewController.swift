//
//  UsersTableViewController.swift
//  ParsJson
//
//  Created by Лилия Андреева on 15.11.2023.
//

import UIKit
import Alamofire

final class UsersTableViewController: UITableViewController {
    
    
    
    
    private let networkManager = NetworkingManager.shared
    var users = [User]()
    
    private let searchController = UISearchController(searchResultsController: nil) //для отображения результатов поиска мы хотим использовать тот же вью где отображается контент (на том же ВК где будети сам поиск)
    
    var filteredRobots = [User]()
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    } //если строка поиска активирована
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        
        //Setup searchC
        searchController.searchResultsUpdater = self // получатель информации об изменении текста в поисковой строке дб наш класс
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true // позволяет отпуска строку поиска при переходе на другой экран
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return }
        
        let robot: User
        
        if isFiltering {
            robot = filteredRobots[indexPath.row]
        } else {
            robot = users[indexPath.row]
        }
        
       // let user = users[indexPath.row]
        let detailVC = segue.destination as? DetailViewController
        detailVC?.robot = robot
    }
}

extension UsersTableViewController {
    //    func fetchUsers() {
    //        networkManager.fetchUsers([User].self, from: Link.userUrl.url) { [unowned self] result in
    //            switch result{
    //
    //            case .success(let dataUsers):
    //                users = dataUsers
    //            case .failure(let error):
    //                print("Error in fetchUsers: \(error)")
    //            }
    //            self.tableView.reloadData()
    //        }
    //    }
    
    func fetchUsers(){
        networkManager.fetchUsers(from: Link.userUrl.url) { result in
            switch result {
            case .success(let users):
                self.users = users
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


    // MARK: - Table view data source
extension UsersTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            filteredRobots.count
        } else{
            users.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        //var robot: User
        
        if isFiltering {
            cell.configure(with: filteredRobots[indexPath.row])
             
        } else {
             cell.configure(with: users[indexPath.row])
        }
        
        //cell.configure(with: users[indexPath.row])
        return cell
    }
}
   
extension UsersTableViewController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchedText(searchController.searchBar.text!) // теперь всякий раз когда пользователь будет взаимодействовать
        // с поисковой строкой UISearchController будет информировать UsersTableViewController вызывая метод updateSearchResults, который будет вызывать filterContentForSearchedText
    }
    
    private func filterContentForSearchedText(_ searchText: String){
        filteredRobots = users.filter({ ( robot: User ) -> Bool in
            return robot.username.lowercased().contains(searchText.lowercased())
            
        })
        tableView.reloadData()
    }
    
}


