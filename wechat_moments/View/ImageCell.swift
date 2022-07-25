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
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        contentView.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.maximumZoomScale = 3.0
        scrollView.minimumZoomScale = 1.0
        tapEvent()
    }
    
    private func configureImageView() {
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: 300)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        scrollView.addSubview(imageView)
    }

    @objc func tapSingleDid() {
        print("tap single")
        UIView.animate(withDuration: 0.5) {
            self.imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
            self.imageView.center = self.center
            if self.scrollView.zoomScale == 3.0 {
                self.scrollView.zoomScale = 1.0
            }
        }
    }

    @objc func tapDoubleDid() {
        UIView.animate(withDuration: 0.5) {
            self.imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            if self.scrollView.zoomScale == 1.0 {
                self.scrollView.zoomScale = 3.0
            }
        }
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture))
        imageView.addGestureRecognizer(panGesture)
    }

    @objc func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: imageView.superview)
        sender.view?.center = CGPoint(
            x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(.zero, in: imageView.superview)
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

}

extension ImageCell: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        imageView.center = scrollView.center
    }
}
