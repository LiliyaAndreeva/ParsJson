//
//  UserTableViewCell.swift
//  ParsJson
//
//  Created by Лилия Андреева on 15.11.2023.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    
    private let networkManager = NetworkingManager.shared
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullNamelabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    func configure(with user: User) {
        fullNamelabel.text = "\(user.first_name) \(user.last_name)"
        userNameLabel.text = "\(user.username)"
        emailLabel.text = "\(user.email)"
        
        let resourse = Kingfisher.KF.ImageResource(downloadURL: URL(string: user.avatar )!)
        avatarImage.kf.setImage(with: resourse)
        
        networkManager.fetchData(from: user.avatar) { result in
            switch result{
            case .success(let imageData):
                self.avatarImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
        
    
    
    

    


