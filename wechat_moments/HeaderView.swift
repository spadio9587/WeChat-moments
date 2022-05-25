//
//  HeaderView.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/5/5.
//

import UIKit

class HeaderView: UIView {
    var userInfo: UserInfo?
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

    func loadImage(from imageUrl: String?, callback: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let imageUrl = imageUrl,
               let url = URL(string: imageUrl),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    callback(image)
                }
            } else {
                DispatchQueue.main.async {
                    callback(nil)
                }
            }
        }
    }
    func setUserInfo(userInfo: UserInfo?) {
        self.userInfo = userInfo
        loadImage(from: userInfo?.profileImage) {
            image in
            self.backgroundView.image = image
        }
        loadImage(from: userInfo?.avatar) {
            image in
            self.userAvatar.image = image
        }
        userNameLabel.text = userInfo?.userName
    }

    func configureBackgroundView() {
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.frame = CGRect(x: 0, y: -44, width: 414, height: 403)
    }
    func configureUserAvatar() {
        userAvatar.contentMode = .scaleAspectFill
        userAvatar.frame = CGRect(x: 321, y: 306, width: 70, height: 70)
    }
    func configureUserNameLabel() {
        userNameLabel.frame = CGRect(x: 240, y: 318, width: 120, height: 52)
    }
}
