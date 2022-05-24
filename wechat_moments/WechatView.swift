//
//  TweetView.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.
// 代码格式！！！
// swift lint
// vscode 调整代码格式

import Foundation
import UIKit

class WechatView: UIView {
    var tweet: Tweet?
    var margin: CGFloat = 8
    var avatarSender = UIImageView()
    var sender = UILabel()
    var containerView = UIStackView()
    var content = UILabel()
    var imageArea = UIView()
    var contentImage = [UIImageView]()
    var commentsArea = UIView()
    var commentsContent = [UILabel]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(avatarSender)
        self.addSubview(sender)
        self.addSubview(containerView)
        configureAvatarSender()
        configureSender()
        configureContainerView()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureContent()
        configureImageArea()
        configureCommentsArea()
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
    func setTweet(tweet: Tweet) {
        self.tweet = tweet
        sender.text = tweet.sender?.username
        loadImage(from: tweet.sender?.avatar) { image in
            self.avatarSender.image = image
        }
        updateContent(tweet.content)
        updateImages(tweet.images)
        updateComments(tweet.comments)
    }
    func updateContent(_ content: String?) {
        if let content = content {
            self.content.text = content
            self.content.isHidden = false
        } else {
            self.content.isHidden = true
        }
    }
    func updateImages(_ images: [Image]?) {
        if let images = images {
            contentImage.removeAll()
            for subview in self.imageArea.subviews {
                subview.removeFromSuperview()
            }
            for index in images.indices {
                let imageView = UIImageView()
                loadImage(from: images[index].url) { image in
                    imageView.image = image
                }
                contentImage.append(imageView)
                imageArea.isHidden = false
            }
        } else {
            imageArea.isHidden = true
        }
    }
    func updateComments(_ comments: [Comment]?) {
        if let comments = comments {
            commentsContent.removeAll()
            for subView in commentsArea.subviews {
                subView.removeFromSuperview()
            }
            for index in comments.indices {
                let labelView = UILabel()
                labelView.text = comments[index].sender.username + ":" + comments[index].content
                commentsContent.append(labelView)
                commentsArea.isHidden = false
            }
        } else {
            commentsArea.isHidden = true
        }
    }
    func configureAvatarSender() {
        avatarSender.contentMode = .scaleAspectFill
        avatarSender.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarSender.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: margin),
            avatarSender.widthAnchor.constraint(equalToConstant: 50),
            avatarSender.heightAnchor.constraint(equalToConstant: 50),
            avatarSender.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: margin)
        ])
    }
    func configureSender() {
        sender.numberOfLines = 1
        sender.textColor = .systemBlue
        sender.font = UIFont.systemFont(ofSize: 17)
        sender.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sender.topAnchor.constraint(equalTo: avatarSender.topAnchor),
            sender.leadingAnchor.constraint(equalTo: avatarSender.trailingAnchor, constant: 10),
            sender.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    func configureContainerView() {
        containerView.axis = .vertical
        containerView.alignment = .leading
        containerView.distribution = .equalSpacing
        containerView.spacing = margin
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addArrangedSubview(content)
        containerView.addArrangedSubview(imageArea)
        containerView.addArrangedSubview(commentsArea)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: sender.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margin),
            containerView.topAnchor.constraint(equalTo: sender.bottomAnchor, constant: margin),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -margin)
        ])
    }
    func configureContent() {
        content.translatesAutoresizingMaskIntoConstraints = false
        content.numberOfLines = 0
        content.lineBreakMode = .byWordWrapping
        content.font = UIFont.systemFont(ofSize: 14)
        if content.text == nil {
            content.isHidden = true
        }
    }
    func configureImageArea() {
        imageArea.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageArea.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        if (contentImage.isEmpty == false) {
                switch contentImage.count {
                case 1 :
                    for count in 0...(contentImage.count-1){
                    let imageView = contentImage[count]
                    imageArea.addSubview(imageView)
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                        print("\(containerView.bounds.size.width)")
                    let width = (containerView.bounds.size.width - 2 * margin)
                    let height = width * 3/4
                    NSLayoutConstraint.activate([
                        imageView.leftAnchor.constraint(equalTo: imageArea.leftAnchor, constant: margin),
                        imageView.topAnchor.constraint(equalTo: imageArea.topAnchor, constant: margin),
                        imageView.widthAnchor.constraint(equalToConstant: width),
                        imageView.heightAnchor.constraint(equalToConstant: height)
                    ])
                    }
                case 2, 4 :
                    for count in 0...(contentImage.count-1){
                    let imageView = contentImage[count]
                    imageArea.addSubview(imageView)
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    let width = (containerView.bounds.size.width - 3 * margin) / 2
                    let height = width
                    let left = CGFloat((count % 2 + 1)) * margin + CGFloat(count % 2) * width
                    let top = CGFloat((count / 2 + 1)) * margin + CGFloat(count / 2) * height
                    NSLayoutConstraint.activate([
                        imageView.leftAnchor.constraint(equalTo: imageArea.leftAnchor, constant: left),
                        imageView.topAnchor.constraint(equalTo: imageArea.topAnchor, constant: top),
                        imageView.widthAnchor.constraint(equalToConstant: width),
                        imageView.heightAnchor.constraint(equalToConstant: height)
                    ])
                    }
                default :
                    for count in 0...(contentImage.count-1) {
                    let imageView = contentImage[count]
                    imageArea.addSubview(imageView)
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    let width = (containerView.bounds.size.width - 4 * margin) / 3
                    let height = (containerView.bounds.size.width - 4 * margin) / 3
                    let left = CGFloat((count % 3 + 1)) * margin + CGFloat(count % 3) * width
                    let top = CGFloat((count / 3 + 1)) * margin + CGFloat(count / 3) * height
                    NSLayoutConstraint.activate([
                        imageView.leftAnchor.constraint(equalTo: imageArea.leftAnchor, constant: left),
                        imageView.topAnchor.constraint(equalTo: imageArea.topAnchor, constant: top),
                        imageView.widthAnchor.constraint(equalToConstant: width),
                        imageView.heightAnchor.constraint(equalToConstant: height)
                    ])
                }
                }
            if let view = imageArea.subviews.last {
                imageArea.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: margin).isActive = true
            }
        } else {
            imageArea.isHidden = true
        }
    }
    func configureCommentsArea() {
        commentsArea.translatesAutoresizingMaskIntoConstraints = false
        commentsArea.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        commentsArea.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        commentsArea.topAnchor.constraint(equalTo: imageArea.bottomAnchor, constant: 5).isActive = true
        if (commentsContent.count) != 0 {
            for count in 0...(commentsContent.count - 1) {
                let seperateComment = commentsContent[count]
                commentsArea.addSubview(seperateComment)
                seperateComment.translatesAutoresizingMaskIntoConstraints = false
                seperateComment.numberOfLines = 0
                var top: CGFloat = 0.0
                let width = UIScreen.main.bounds.size.width
                let height = UIScreen.main.bounds.size.height
                let strSize: CGSize = (seperateComment.sizeThatFits(CGSize.init(width: width-60-25, height: height)))
                seperateComment.frame = CGRect(x: 5.0, y: 3.0, width: strSize.width, height: strSize.height)
                top = CGFloat(count) * strSize.height + CGFloat(count) * 18
                NSLayoutConstraint.activate([
                    seperateComment.topAnchor.constraint(equalTo: commentsArea.topAnchor, constant: top),
                    seperateComment.leadingAnchor.constraint(equalTo: commentsArea.leadingAnchor),
                    seperateComment.trailingAnchor.constraint(equalTo: commentsArea.trailingAnchor, constant: -8)
                ])
                let mutableAttribString = NSMutableAttributedString(attributedString: NSAttributedString(string: seperateComment.text!, attributes: [.kern: -0.5]))
                let number = seperateComment.text!.firstIndex(of: ":")
                mutableAttribString.addAttributes(
                    [.foregroundColor: UIColor.blue],
                    range: NSRange(location: 0, length: seperateComment.text![..<number!].count)
                )
                seperateComment.attributedText = mutableAttribString
            }
            if let comment = commentsArea.subviews.last {
                commentsArea.bottomAnchor.constraint(equalTo: comment.bottomAnchor, constant: margin).isActive = true
            }
        } else {
            commentsArea.isHidden = true
        }
    }
}
