//
//  ProfileViewController.swift
//  Navigation
//
//  Created by G on 13.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    override func viewWillLayoutSubviews() {
        let profileHeader = ProfileHeaderView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
        view.addSubview(profileHeader)
    }
}
    
