//
//  ImageView.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/14.
//

import UIKit

class ImageView: UIView {
    private let label = UILabel()
    let tapImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImage()
        configureLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel() {
        addSubview(label)
        label.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
    }
    
    private func configureImage() {
        addSubview(tapImageView)
        tapImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tapImageView.topAnchor.constraint(equalTo: topAnchor),
            tapImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tapImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tapImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        tapImageView.contentMode = .scaleAspectFill
    }
}
