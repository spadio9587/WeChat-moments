//
//  ImagePreviewCell.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/12.
//

import UIKit

public class ImageCell: UICollectionViewCell {
    private var scrollView = UIScrollView()
    let imageView = ImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(scrollView)
        configureImageView()
        configureScrollView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureScrollView() {
        scrollView = UIScrollView(frame: contentView.bounds)
        scrollView.maximumZoomScale = 3.0
        scrollView.minimumZoomScale = 1.0
        scrollView.delegate = self
        let tapDouble = UITapGestureRecognizer(target: self, action: #selector(tapDoubleDid))
        tapDouble.numberOfTapsRequired = 2
        tapDouble.numberOfTouchesRequired = 1
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(tapSingleDid))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        tapSingle.require(toFail: tapDouble)
        imageView.addGestureRecognizer(tapDouble)
        imageView.addGestureRecognizer(tapSingle)
    }

    @objc func tapSingleDid() {
        print("tap single")
        UIView.animate(withDuration: 0.5) {
            if self.scrollView.zoomScale == 3.0 {
                self.scrollView.zoomScale = 1.0
            }
        }
    }

    @objc func tapDoubleDid() {
        print("tap twice")
        UIView.animate(withDuration: 0.5) {
            if self.scrollView.zoomScale == 1.0 {
                self.scrollView.zoomScale = 3.0
            }
        }
    }

    private func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

extension ImageCell: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView.tapImageView
    }

    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        imageView.tapImageView.center = scrollView.center
    }
}
