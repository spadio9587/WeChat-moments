//
//  ImagePreviewCell.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/12.
//

import UIKit

public class ImageCell: UICollectionViewCell {
    private var wechatView: WechatView!
    private var scrollView: UIScrollView?
    private var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .black
        wechatView = WechatView()
        configureImageView()
        configureScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureScrollView() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width*3, height: 200))
        scrollView.alwaysBounceHorizontal = false
        scrollView.backgroundColor = .blue
        contentView.addSubview(scrollView)
        scrollView.maximumZoomScale = 3.0
        scrollView.minimumZoomScale = 1.0
    }
    private func configureImageView() {
        imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 350, width: UIScreen.main.bounds.width, height: 100)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        contentView.addSubview(imageView)
    }
    
    public func setImage(tweet: Tweet?) {
        guard let tweet = tweet else { return }
        wechatView.setImage(tweet: tweet)
        layoutIfNeeded()
    }
}
