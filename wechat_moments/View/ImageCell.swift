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
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        contentView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        scrollView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        guard let image = imageView.image else { return }
        let screenRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        let imageRatio = image.size.width / image.size.height
        if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
            if imageRatio > screenRatio {
                imageView.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - (scrollView.bounds.width * 1 / imageRatio)) / 2, width: scrollView.bounds.width, height: scrollView.bounds.width * 1 / imageRatio)
            } else {
                imageView.frame = CGRect(x: (UIScreen.main.bounds.width - (scrollView.bounds.height * imageRatio)) / 2, y: 0, width: scrollView.bounds.height * imageRatio, height: scrollView.bounds.height)
            }
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFill
        } else if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            if imageRatio < screenRatio {
                imageView.frame = CGRect(x: (UIScreen.main.bounds.width - (scrollView.bounds.height * imageRatio)) / 2, y: 0, width: scrollView.bounds.height * imageRatio, height: scrollView.bounds.height)
            } else {
                imageView.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - (scrollView.bounds.width * 1 / imageRatio)) / 2, width: scrollView.bounds.width, height: scrollView.bounds.width * 1 / imageRatio)
            }
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFill
        }
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
        scrollView.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
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
                } else {
                    if newTapPositonPicture.y > imageView.frame.size.height - scrollView.frame.size.height {
                        scrollView.contentOffset = CGPoint(x: newTapPositonPicture.x - tapPositionOfScreen.x, y: imageView.frame.size.height - scrollView.frame.size.height)
                    } else {
                        scrollView.contentOffset = CGPoint(x: newTapPositonPicture.x - tapPositionOfScreen.x, y: newTapPositonPicture.y - tapPositionOfScreen.y)
                    }
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
