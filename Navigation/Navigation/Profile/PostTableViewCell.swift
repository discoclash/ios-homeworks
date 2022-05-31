//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by G on 19.05.2022.
//

import UIKit

protocol DetailPostDelegate: AnyObject {
    func presentDetailPostVC(indexPath: IndexPath?, author: UILabel, image: UIImageView, discripton: UILabel, likes: Int, views: Int, isLiked: Bool)
}

class PostTableViewCell: UITableViewCell {
    
    weak var delegate: DetailPostDelegate?
    
    var indexPath: IndexPath?

    private var likes: Int = 0
    private var views: Int = 0
    private var isLiked: Bool = false
    private var isViewed: Bool = false
    
    
    private let authorLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = .clear
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private let postImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let  discriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemGray
        $0.font = .systemFont(ofSize: 14)
        $0.backgroundColor = .clear
        $0.numberOfLines = 5
        return $0
    }(UILabel())
    
    private let likesLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .clear
        return $0
    }(UILabel())
    
    private let  viewsLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .clear
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell (_ model: PostModel) {
        authorLabel.text = model.author
        postImage.image = UIImage(named: model.image)
        discriptionLabel.text = model.discription
        likes = model.likes
        views = model.views
        isLiked = model.isLiked
        if isLiked {
            likesLabel.textColor = .systemRed
        }
        isViewed = model.isViewed
        if isViewed {
            viewsLabel.textColor = colorSet
        }
        likesLabel.text = "Лайков: \(likes)"
        viewsLabel.text = "Просмотров: \(views)"
    }
    
    private func setupGestures() {
        let tapOnLabel = UITapGestureRecognizer(target: self, action: #selector(tapLabel))
        let tapOnImage = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(tapOnImage)
        likesLabel.isUserInteractionEnabled = true
        likesLabel.addGestureRecognizer(tapOnLabel)
    }
    
    @objc private func tapLabel() {
        if !isLiked {
            likes += 1
            likesLabel.text = "Лайков: \(likes)"
            likesLabel.textColor = .systemRed
            isLiked.toggle()
            if let i = indexPath {
                postsModel[i.row].likes += 1
                postsModel[i.row].isLiked.toggle()
                print("\(postsModel[i.row].author) - \(postsModel[i.row].likes) лайков")
            }
        } else {
            likes -= 1
            likesLabel.text = "Лайков: \(likes)"
            likesLabel.textColor = .black
            isLiked.toggle()
            if let i = indexPath {
                postsModel[i.row].likes -= 1
                postsModel[i.row].isLiked.toggle()
                print("\(postsModel[i.row].author) - \(postsModel[i.row].likes) лайков")
            }
        }
    }
    
    @objc private func tapImage() {
        if !isViewed {
            views += 1
            viewsLabel.text = "Просмотров: \(views)"
            viewsLabel.textColor = colorSet
            isViewed.toggle()
            if let i = indexPath {
                postsModel[i.row].views += 1
                postsModel[i.row].isViewed.toggle()
                print("\(postsModel[i.row].author) - \(postsModel[i.row].views) просмотров")
            }
        }
        delegate?.presentDetailPostVC(indexPath: indexPath, author: authorLabel, image: postImage, discripton: discriptionLabel, likes: likes, views: views, isLiked: isLiked)
    }
    

    private func layout() {
        [authorLabel, postImage, discriptionLabel, likesLabel, viewsLabel].forEach { contentView.addSubview($0) }
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: inset),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            discriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: inset),
            discriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            discriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            likesLabel.topAnchor.constraint(equalTo: discriptionLabel.bottomAnchor, constant: inset),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            
            viewsLabel.topAnchor.constraint(equalTo: discriptionLabel.bottomAnchor, constant: inset),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}
