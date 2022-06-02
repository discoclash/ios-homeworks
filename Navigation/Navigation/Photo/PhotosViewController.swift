//
//  PhotosViewController.swift
//  Navigation
//
//  Created by G on 24.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collection
    }()

    override func viewDidLoad() {
        self.navigationItem.title = "Фото"
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
}


extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell(imageName: "\(indexPath.item + 1)")
        return cell
    }
}
 
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
                let width = (collectionView.bounds.width - sideInset * 4) / 3
                return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentPhoto(indexOfPhoto: indexPath.item)
    }
}

extension PhotosViewController {
    
    func presentPhoto(indexOfPhoto: Int) {
        let photoImageView: UIImageView = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.image = UIImage(named: "\(indexOfPhoto + 1)")
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
            $0.isUserInteractionEnabled = true
            return $0
        }(UIImageView())
        
        view.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let tapToImage = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        photoImageView.addGestureRecognizer(tapToImage)
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
}
