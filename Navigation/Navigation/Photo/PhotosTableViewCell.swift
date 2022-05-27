//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by G on 24.05.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Фото"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let photosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let goToPhotosImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        for i in 1...4 {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "\(i)")
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 6
            photosStackView.addArrangedSubview(imageView)
        }
        
        [label, goToPhotosImage, photosStackView].forEach { contentView.addSubview($0) }
        
        let inset: CGFloat = 12
        let sideInset: CGFloat = 8
        let imageSide: CGFloat = (UIScreen.main.bounds.width - inset * 2 - sideInset * 3) / 4
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            
            goToPhotosImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            goToPhotosImage.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            
            photosStackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: inset),
            photosStackView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            photosStackView.heightAnchor.constraint(equalToConstant: imageSide),
            photosStackView.trailingAnchor.constraint(equalTo: goToPhotosImage.trailingAnchor),
            photosStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}
