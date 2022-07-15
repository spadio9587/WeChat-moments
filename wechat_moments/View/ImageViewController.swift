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
    var tweet: Tweet? {
        didSet {
            updateCollection()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    var imageView = ImageView()
//    var imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(imageView)
//        configureImageView()
        view.backgroundColor = .white
        
    }
    
    private func updateCollection() {
        collectionView.reloadData()
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
        guard let tweet = tweet else { return 0 }
        return tweet.images!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        imageCell.setImage(tweet: tweet)
        return imageCell
    }
}
