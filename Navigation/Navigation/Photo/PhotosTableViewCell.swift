//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by G on 24.05.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private let label: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Фото"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 24)
        return $0
    }(UILabel())
    
    private let goToPhotosImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "arrow.right")
        $0.backgroundColor = .clear
        return $0
    }(UIImageView())
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isUserInteractionEnabled = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collection
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        [label, goToPhotosImage, collectionView].forEach { contentView.addSubview($0) }
        
        let inset: CGFloat = 12
        let sideInset: CGFloat = 8
        let imageSide: CGFloat = (UIScreen.main.bounds.width - inset * 2 - sideInset * 3) / 4
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            
            goToPhotosImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            goToPhotosImage.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: inset),
            collectionView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: imageSide),
            collectionView.trailingAnchor.constraint(equalTo: goToPhotosImage.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell(imageName: "\(indexPath.item + 1)")
        cell.contentView.layer.cornerRadius = 6
        cell.contentView.clipsToBounds = true
        return cell
    }
}
 
extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
                let height = collectionView.bounds.height
                return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
}
