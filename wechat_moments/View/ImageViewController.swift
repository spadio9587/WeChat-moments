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
    private var pageControl: UIPageControl!
    var index: Int! = nil
    var imageViewModel: ImageViewModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionView()
        configurePageControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
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
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 300, width: Int(UIScreen.main.bounds.width), height: 300), collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.backgroundColor = .lightGray
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    private func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 140, y: 570, width: 150, height: 20))
        view.addSubview(pageControl)
        if imageViewModel!.images.count == 1 {
            pageControl.isHidden = true
        }
        pageControl.numberOfPages = (imageViewModel?.images.count)!
        pageControl.currentPage = index
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = .white
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
        let image = imageViewModel.images[indexPath.row]
        imageCell.imageView.tapImageView.image = image
        return imageCell
    }
}

extension ImageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleCell = collectionView.visibleCells[0]
        pageControl.currentPage = collectionView.indexPath(for: visibleCell)!.item
    }
}
