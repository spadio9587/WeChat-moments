//
//  ImageView.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/14.
//

import UIKit

class ImageView: UIView {
    private var tweet: Tweet?
    private var label = UILabel()
    private var pageControl = UIPageControl()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
        configurePageControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        pageControl.numberOfPages = 4
    }
    
    func setImage(imageViewModel: ImageViewModel) {
        for subview in subviews {
            if subview is UIImageView {
                subview.removeFromSuperview()
            }
        }
        
        for index in 0...(imageViewModel.images.count - 1) {
            let imageView = UIImageView(frame: CGRect(x: bounds.width * CGFloat(index), y: 0, width: bounds.width, height: bounds.height))
            imageView.image = imageViewModel.images[index]
            addSubview(imageView)
            imageView.contentMode = .scaleAspectFill
        }
    }
}
