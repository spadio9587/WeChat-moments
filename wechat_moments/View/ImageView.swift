//
//  ImageView.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/14.
//

import UIKit

class ImageView: UIView {
    private var tweet: Tweet?
    private var imageContent = [UIImageView]()
    private var label = UILabel()
    private var pageControl = UIPageControl()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
        configureImageView()
        configurePageControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage(from imageUrl: String?, callback: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            guard let imageUrl = imageUrl,
                  let url = URL(string: imageUrl),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                callback(image)
            }
        }
    }
    
    private func configureLabel() {
        addSubview(label)
        label.text = "What are u doing"
        label.frame = CGRect(x: 0, y: 0, width: 300, height: 20)
    }
    
    private func configurePageControl() {
        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 120).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        pageControl.numberOfPages = 6
    }
    
    public func setImage(tweet: Tweet) {
        self.tweet = tweet
        for im in tweet.images {
            let imageView = UIImageView()
            imageView.image = im
            imageContent.append(imageView)
        }
    }
    
    func updateImages(_ images: [UIImage]?) {
        guard let images = images else {
            return
        }
        for im in images {
            let imageView = UIImageView()
            imageView.image = im
            imageContent.append(imageView)
        }
    }
    
    func configureImageView() {
        for imageView in imageContent {
            if imageContent.count == 1 {
            addSubview(imageView)
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        }
        }
    }
}
