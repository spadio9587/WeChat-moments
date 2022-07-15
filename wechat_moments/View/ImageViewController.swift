//
//  ImageViewController.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/12.
//

import UIKit

class ImageViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewFlowLayout!
    private let imageViewModel = ImageViewModel()
    var image: [Image]? = []
    var imageView = ImageView()
//    var imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(imageView)
//        configureImageView()
        view.backgroundColor = .white
        configureCollectionView()
    }
    
//    private func configureImageView() {
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
//        imageView.contentMode = .scaleAspectFit
//    }
    
    private func configureCollectionView() {
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 300, width: Int(UIScreen.main.bounds.width) * 3, height: 300), collectionViewLayout: collectionViewLayout)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.backgroundColor = .lightGray
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        view.addSubview(collectionView)
    }
}


extension ImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        imageCell.setImage(tweet: image![indexPath.row])
        return imageCell
    }
}
