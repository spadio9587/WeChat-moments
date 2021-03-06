//
//  HeaderView.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/5/5.
//

import UIKit

private enum HeConstant {
    // 背景的宽，高
    static let backgroundFrame: CGFloat = 360
    // 使用者头像的位置
    static let userAvatarLocation: CGFloat = 310
    // 使用者头像的宽，高
    static let userAvaterFrame: CGFloat = 70
    // 使用者名字的位置
    static let nameLabelLocation: CGFloat = 335
    // 间隙
    static let margin: CGFloat = 8
}

public class HeaderView: UIView {
    var userInfo: UserInfo?
    let backgroundView = UIImageView()
    let userAvatar = UIImageView()
    let userNameLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundView)
        addSubview(userAvatar)
        addSubview(userNameLabel)
        configureBackgroundView()
        configureUserAvatar()
        configureUserNameLabel()
        layoutIfNeeded()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadImage(from imageUrl: String?, callback: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            guard let imageUrl = imageUrl,
                  let url = URL(string: imageUrl),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                callback(image)
            }
        }
    }

    public func setUserInfo(userInfo: UserInfo?) {
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

    private func configureBackgroundView() {
        // 通过屏幕高度宽度判断屏幕是横评还是竖屏并设置
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: -88),
            backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            backgroundView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.50)
        ])
    }

    private func configureUserAvatar() {
        userAvatar.contentMode = .scaleAspectFill
        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userAvatar.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: UIScreen.main.bounds.width * 0.85),
            userAvatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.height * 0.34),
            userAvatar.widthAnchor.constraint(equalToConstant: HeConstant.userAvaterFrame),
            userAvatar.heightAnchor.constraint(equalToConstant: HeConstant.userAvaterFrame)
        ])
    }

    private func configureUserNameLabel() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.numberOfLines = 1
        NSLayoutConstraint.activate([
            userNameLabel.rightAnchor.constraint(equalTo: userAvatar.leftAnchor, constant: -HeConstant.margin),
            userNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: HeConstant.nameLabelLocation)
        ])
    }
}
