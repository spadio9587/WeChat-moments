//
//  HeaderView.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/5/5.
//

import UIKit

private enum HeConstant {
    static let backgroundFrameY: CGFloat = -50
    static let avatarVerticalX: CGFloat = 280
    static let avatarVerticalY: CGFloat = 285
    static let avatarHorizontalX: CGFloat = 720
    static let avaterSize: CGFloat = 70
    static let nameVerticalX: CGFloat = 200
    static let nameVerticalY: CGFloat = 310
    static let nameHorizontalX: CGFloat = 625
    static let nameHorizontalY: CGFloat = 305
    static let nameWidth: CGFloat = 100
    static let nameHeight: CGFloat = 30
    // 间隙
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
        layoutIfNeeded()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        configureBackgroundView()
        configureUserAvatar()
        configureUserNameLabel()
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
        if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
            backgroundView.frame = CGRect(x: 0, y: HeConstant.backgroundFrameY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 9 / 20)
        } else {
            backgroundView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 1 / 3)
        }
    }

    private func configureUserAvatar() {
        userAvatar.contentMode = .scaleAspectFill
        if UIScreen.main.bounds.height > UIScreen.main.bounds.width {
            userAvatar.frame = CGRect(x: HeConstant.avatarVerticalX, y: HeConstant.avatarVerticalY, width: HeConstant.avaterSize, height: HeConstant.avaterSize)
        } else {
            userAvatar.frame = CGRect(x: HeConstant.avatarHorizontalX, y: HeConstant.avatarVerticalX, width: HeConstant.avaterSize, height: HeConstant.avaterSize)
        }
    }

    private func configureUserNameLabel() {
        userNameLabel.numberOfLines = 1
        if UIScreen.main.bounds.height > UIScreen.main.bounds.width {
            userNameLabel.frame = CGRect(x: HeConstant.nameVerticalX, y: HeConstant.nameVerticalY, width: HeConstant.nameWidth, height: HeConstant.nameHeight)
        } else {
            userNameLabel.frame = CGRect(x: HeConstant.nameHorizontalX, y: HeConstant.nameHorizontalY, width: HeConstant.nameWidth, height: HeConstant.nameHeight)
        }
    }
}
