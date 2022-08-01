//
//  ImageViewController.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/12.
//

import UIKit

private enum Constant {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

class ImageViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewFlowLayout!
    private var pageControl: UIPageControl!
    var index: Int! = nil
    var imageViewModel: ImageViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureCollectionView()
        configurePageControl()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            coordinator.animate(alongsideTransition: nil) { _ in
                    print("rotated rotate")
                    self.collectionView.reloadData()
            }
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }

    private func configureCollectionView() {
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.contentInsetAdjustmentBehavior = .never
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }

    private func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: (UIScreen.main.bounds.width / 2 - 150 / 2), y:(UIScreen.main.bounds.height - 30), width: 150, height: 20))
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
        imageCell.imageView.image = image
        return imageCell
    }
}

extension ImageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleCell = collectionView.visibleCells[0]
        pageControl.currentPage = collectionView.indexPath(for: visibleCell)!.item
    }
}
