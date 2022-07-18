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
    var imageViewModel: ImageViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    private func configureCollectionView() {
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
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
        (imageViewModel?.images.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let imageViewModel = imageViewModel, let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        imageCell.setImageViewModel(imageViewModel: imageViewModel)
        return imageCell
    }
}
