//
//  HeaderView.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/5/5.
//

import UIKit

class HeaderView: UIView {
    let backgroundView = UIImageView()
    let userAvatar = UIImageView()
    let userNameLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backgroundView)
        self.addSubview(userAvatar)
        self.addSubview(userNameLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureBackgroundView()
        configureUserAvatar()
        configureUserNameLabel()
    }
    func configureBackgroundView() {
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.image = UIImage.init(named: "profile-image")
        backgroundView.frame = CGRect(x: 0, y: -44, width: 414, height: 403)
    }
    func configureUserAvatar() {
        userAvatar.contentMode = .scaleAspectFill
        userAvatar.image = UIImage.init(named: "avatar")
        userAvatar.frame = CGRect(x: 321, y: 306, width: 70, height: 70)
    }
    func configureUserNameLabel() {
        userNameLabel.text = "Shawn"
        userNameLabel.frame = CGRect(x: 260, y: 322, width: 120, height: 52)
    }
}
