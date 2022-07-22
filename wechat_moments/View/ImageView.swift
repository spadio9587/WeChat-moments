//
//  ImageView.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/14.
//

import UIKit

class ImageView: UIView {
    var tapImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImage()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureImage() {
        addSubview(tapImageView)
        tapImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tapImageView.topAnchor.constraint(equalTo: topAnchor),
            tapImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tapImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tapImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        tapImageView.contentMode = .scaleAspectFill
    }
}
