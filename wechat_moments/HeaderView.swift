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
    let backgroundFrame: CGFloat = 360
    let userAvaterLocation: CGFloat = 310
    let userAvaterFrame: CGFloat = 70
    let gap: CGFloat = 5
    let nameLabelLocation: CGFloat = 335
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundView)
        addSubview(userAvatar)
        addSubview(userNameLabel)
        configureBackgroundView()
        configureUserAvatar()
        configureUserNameLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            backgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: backgroundFrame),
            backgroundView.heightAnchor.constraint(equalToConstant: backgroundFrame)
        ])
    }
    
    func configureUserAvatar() {
        userAvatar.contentMode = .scaleAspectFill
        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userAvatar.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: userAvaterLocation),
            userAvatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: userAvaterLocation),
            userAvatar.widthAnchor.constraint(equalToConstant: userAvaterFrame),
            userAvatar.heightAnchor.constraint(equalToConstant: userAvaterFrame)
        ])
    }
    
    func configureUserNameLabel() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.numberOfLines = 1
        NSLayoutConstraint.activate([
            userNameLabel.rightAnchor.constraint(equalTo: userAvatar.leftAnchor, constant: gap),
            userNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: nameLabelLocation)
        ])
    }
}
