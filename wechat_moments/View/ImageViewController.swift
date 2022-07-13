//
//  ImageViewController.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/12.
//

import UIKit

class ImageViewController: UIViewController {
    public var index: Int?
    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewFlowLayout!
    private let viewModel = TweetViewModel()
//    private var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
//        collectionViewLayout.sectionInset = UIEdgeInsets.zero
        collectionViewLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        viewModel.getDataFromUrl(callback: {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width*3, height: UIScreen.main.bounds.height), collectionViewLayout: collectionViewLayout)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        view.addSubview(collectionView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("index number \(self.index ?? 0)")
    }
}

extension ImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.tweet[section].images!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        imageCell.setImage(tweet: viewModel.tweet[indexPath.row])
        return imageCell
    }
}
