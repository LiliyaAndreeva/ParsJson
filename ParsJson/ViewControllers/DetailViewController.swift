//
//  DetailViewController.swift
//  ParsJson
//
//  Created by Лилия Андреева on 15.11.2023.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {

    var user: User!
    
    @IBOutlet weak var usersAvatarImageView: UIImageView!
    @IBOutlet weak var usersDescribeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser(user)
    }
    
    private func getUser(_ user: User) {
        usersDescribeLabel.text = user.describe
        let resourse = Kingfisher.KF.ImageResource(downloadURL: URL(string: user.avatar )!)
        usersAvatarImageView.kf.setImage(with: resourse)
    }

}
