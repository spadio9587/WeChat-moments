//
//  ImagePreviewCell.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/12.
//

import UIKit

public class ImageCell: UICollectionViewCell {
    private var scrollView = UIScrollView()
    let imageView = UIImageView()
    let currentVC = ImageViewController()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureScrollView()
        configureImageView()
        layoutIfNeeded()
//        NotificationCenter.default.addObserver(self, selector: #selector(updateLayout), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    public override func layoutSubviews() {
//        layoutIfNeeded()
//    }

//    @objc func updateLayout() {
//        if UIDevice.current.orientation.isLandscape {
//            self.imageView.frame = CGRect(x: 300, y: 0, width: 300, height: UIScreen.main.bounds.height)
//        }
//    }

    override public func prepareForReuse() {
        layoutIfNeeded()
    }

    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        contentView.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.maximumZoomScale = 3.0
        scrollView.minimumZoomScale = 1.0
        tapEvent()
    }

    private func configureImageView() {
        // 垂直水平居中
        if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
            imageView.frame = CGRect(x: 0, y: 300, width: scrollView.bounds.width, height: scrollView.bounds.width * 3 / 4)
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
        } else if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            imageView.frame = CGRect(x: 300, y: 0, width: UIScreen.main.bounds.height * 3 / 4, height: UIScreen.main.bounds.height)
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFill
            scrollView.addSubview(imageView)
        }

    }

    @objc func tapSingleDid() {
        if let currentVC = self.responderViewController() {
            currentVC.navigationController?.popViewController(animated: false)
        }
    }

    @objc func tapDoubleDid(recognizer: UITapGestureRecognizer) {
        let tapPositionOfPicture = recognizer.location(in: imageView)
        let tapPositionOfScreen = recognizer.location(in: scrollView)
        UIView.animate(withDuration: 0.5) { [self] in
            if scrollView.zoomScale == scrollView.minimumZoomScale {
                scrollView.zoomScale = scrollView.maximumZoomScale
                let newTapPositonPicture = CGPoint(x: tapPositionOfPicture.x * scrollView.zoomScale, y: tapPositionOfPicture.y * scrollView.zoomScale)
                if newTapPositonPicture.y < scrollView.frame.size.height {
                    scrollView.contentOffset = CGPoint(x: newTapPositonPicture.x - tapPositionOfScreen.x, y: 0)
                }
            } else {
                scrollView.zoomScale = scrollView.minimumZoomScale
            }
        }
    }

    @objc func respondToSwipeGesture() {
        if let viewController = self.responderViewController() {
            viewController.navigationController?.popViewController(animated: false)
        }
    }

    private func tapEvent() {
        let tapDouble = UITapGestureRecognizer(target: self, action: #selector(tapDoubleDid))
        tapDouble.numberOfTapsRequired = 2
        tapDouble.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tapDouble)
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(tapSingleDid))
        imageView.addGestureRecognizer(tapSingle)
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        tapSingle.require(toFail: tapDouble)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeUp.direction = .up
        imageView.addGestureRecognizer(swipeUp)
    }

    func responderViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self) {
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
}

extension ImageCell: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        var centerX = scrollView.center.x
        var centerY = scrollView.center.y
        centerX = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width / 2 : centerX
        centerY = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height / 2 : centerY
        print(centerX, centerY)
        imageView.center = CGPoint(x: centerX, y: centerY)
    }
}
