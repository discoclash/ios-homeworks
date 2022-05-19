//
//  PostModel.swift
//  Navigation
//
//  Created by G on 18.05.2022.
//

import UIKit

struct PostModel {
    let author: String
    var image: UIImage
    var discription: String?
    var likes: Int = 0
    var views: Int = 0
}

var postsModel = [
    PostModel(author: "Джорджик", image: UIImage(named: "nigga")!, discription: "Май нигга"),
    PostModel(author: "Жорик", image: UIImage(named: "shiba")!, discription: "Чет я устал"),
    PostModel(author: "Гошанчик", image: UIImage(named: "husky")!, discription: "Я ХАСКЕ!"),
    PostModel(author: "Фомик", image: UIImage(named: "hatiko")!)
]
