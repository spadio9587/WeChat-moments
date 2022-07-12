//
//  ImageViewController.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/12.
//

import UIKit

class ImageViewController: UIViewController {
    var collectionView: UICollectionView!
    var collectionViewLayout: UICollectionViewFlowLayout!
    var pageControl: UIPageControl!
    var wechatView: WechatView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .black
        collectionView.register(ImagePreviewCell.self, forCellWithReuseIdentifier: "ImagePreviewCell")
        collectionView.isPagingEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        view.addSubview(collectionView)
        pageControl = UIPageControl()
        pageControl.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 10)
        pageControl.isUserInteractionEnabled = false
        view.addSubview(pageControl)
    }
}
