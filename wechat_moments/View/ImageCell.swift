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

    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height))
        contentView.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 1.0
        tapEvent()
    }

    private func configureImageView() {
        imageView.frame = CGRect(x: 0, y: 300, width: scrollView.bounds.width, height: 300)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        scrollView.addSubview(imageView)
    }

    @objc func tapSingleDid() {
        if let currentVC = self.responderViewController() {
            currentVC.navigationController?.popViewController(animated: false)
        }
    }

    @objc func tapDoubleDid(recognizer: UITapGestureRecognizer) {
        let point = recognizer.location(in: self.imageView)
        UIView.animate(withDuration: 0.5) { [self] in
            if scrollView.zoomScale == 1.0 {
                scrollView.zoomScale = 4.0
            } else {
                scrollView.zoomScale = 1.0
            }
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
        centerX = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : centerX
        centerY = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : centerY
        print(centerX, centerY)
        imageView.center = CGPoint(x: centerX, y: centerY)
    }
}
