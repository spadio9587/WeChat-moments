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
    var labelSpace: CGFloat = 5
    let avatarFrame: CGFloat = 50
    let fontSize: CGFloat = 17
    let attCoefficient: CGFloat = -0.5
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
        addSubview(avatarSender)
        addSubview(sender)
        addSubview(containerView)
        configureAvatarSender()
        configureSender()
        configureContainerView()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureContent()
        configureImageArea()
        configureCommentsArea()
    }
    
    func loadImage(from  imageUrl: String?, callback: @escaping (UIImage?) -> Void) {
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
        guard let content = content else { return }
        self.content.text = content
        self.content.isHidden = false
    }
    
    func updateImages(_ images: [Image]?) {
        guard let images = images else { return }
        contentImage.removeAll()
        imageArea.isHidden = false
        removeSubviews(view: imageArea)
        for index in images.indices {
            let imageView = UIImageView()
            loadImage(from: images[index].url) { image in
                imageView.image = image
            }
            contentImage.append(imageView)
        }
    }
    
    func removeSubviews(view: UIView) {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func updateComments(_ comments: [Comment]?) {
        guard let comments = comments else { return }
        commentsContent.removeAll()
        removeSubviews(view: commentsArea)
        for index in comments.indices {
            let labelView = UILabel()
            labelView.text = comments[index].sender.username + ":" + " " + comments[index].content
            commentsContent.append(labelView)
            commentsArea.isHidden = false
        }
    }
    
    func configureAvatarSender() {
        avatarSender.contentMode = .scaleAspectFill
        avatarSender.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarSender.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: margin),
            avatarSender.widthAnchor.constraint(equalToConstant: avatarFrame),
            avatarSender.heightAnchor.constraint(equalToConstant: avatarFrame),
            avatarSender.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin)
        ])
    }
    
    func configureSender() {
        sender.numberOfLines = 1
        sender.textColor = .systemBlue
        sender.font = UIFont.systemFont(ofSize: fontSize)
        sender.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sender.topAnchor.constraint(equalTo: avatarSender.topAnchor),
            sender.leadingAnchor.constraint(equalTo: avatarSender.trailingAnchor, constant: margin),
            sender.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin)
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
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            containerView.topAnchor.constraint(equalTo: sender.bottomAnchor, constant: margin),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureContent() {
        content.translatesAutoresizingMaskIntoConstraints = false
        content.numberOfLines = 0
        content.lineBreakMode = .byWordWrapping
        content.font = UIFont.systemFont(ofSize: fontSize)
        content.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2 * margin).isActive = true
        if content.text == nil {
            content.isHidden = true
        }
    }
    
    func configureImageArea() {
        imageArea.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageArea.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        if contentImage.isEmpty == false {
            switch contentImage.count {
            case 1:
                for count in 0 ... (contentImage.count - 1) {
                    let width = (UIScreen.main.bounds.width - avatarFrame - 3 * margin - 3 - 2 * margin)
                    let height = width * 3 / 4
                    let left = 0
                    let top = 0
                    setImageConstraint(count: count, leftEdge: Float(left), topEdge: Float(top), imageWidth: Float(width), imageHeight: Float(height))
                }
            case 2, 4:
                for count in 0 ... (contentImage.count - 1) {
                    let width = (UIScreen.main.bounds.width - avatarFrame - 3 * margin - 3 * margin) / 2
                    let height = width
                    let left = CGFloat(count % 2) * margin + CGFloat(count % 2) * width
                    let top = CGFloat(count / 2 + 1) * margin + CGFloat(count / 2) * height
                    setImageConstraint(count: count, leftEdge: Float(left), topEdge: Float(top), imageWidth: Float(width), imageHeight: Float(height))
                }
            default:
                for count in 0 ... (contentImage.count - 1) {
                    let width = (UIScreen.main.bounds.width - avatarFrame - 3 * margin - 4 * margin) / 3
                    let height = width
                    let left = CGFloat(count % 3) * margin + CGFloat(count % 3) * width
                    let top = CGFloat(count / 3 + 1) * margin + CGFloat(count / 3) * height
                    setImageConstraint(count: count, leftEdge: Float(left), topEdge: Float(top), imageWidth: Float(width), imageHeight: Float(height))
                }
            }
            guard let view = imageArea.subviews.last else {
                return
            }
            imageArea.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: margin).isActive = true
        }
    }
    
    func configureCommentsArea() {
        commentsArea.translatesAutoresizingMaskIntoConstraints = false
        commentsArea.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        commentsArea.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: margin).isActive = true
        commentsArea.topAnchor.constraint(equalTo: imageArea.bottomAnchor).isActive = true
        commentsArea.backgroundColor = .systemGray6
        if (commentsContent.count) != 0 {
            func setSpecialColorText(seperateComment: UILabel) {
                let mutableAttribString = NSMutableAttributedString(attributedString: NSAttributedString(string: seperateComment.text!, attributes: [.kern: attCoefficient]))
                let number = seperateComment.text!.firstIndex(of: ":")
                mutableAttribString.addAttributes(
                    [.foregroundColor: UIColor.blue],
                    range: NSRange(location: 0, length: seperateComment.text![..<number!].count)
                )
                seperateComment.attributedText = mutableAttribString
            }
            switch commentsContent.count {
            case 1:
                let seperateComment = commentsContent[0]
                commentsArea.addSubview(seperateComment)
                seperateComment.translatesAutoresizingMaskIntoConstraints = false
                seperateComment.numberOfLines = 0
                NSLayoutConstraint.activate([
                    seperateComment.topAnchor.constraint(equalTo: commentsArea.topAnchor, constant: labelSpace),
                    seperateComment.leadingAnchor.constraint(equalTo: commentsArea.leadingAnchor),
                    seperateComment.trailingAnchor.constraint(equalTo: commentsArea.trailingAnchor, constant: -margin)
                ])
                setSpecialColorText(seperateComment: seperateComment)
                
            default:
                let count = commentsContent.count
                let seperateComment = commentsContent[count - 2]
                let nextSeperateComment = commentsContent[count - 1]
                commentsArea.addSubview(seperateComment)
                commentsArea.addSubview(nextSeperateComment)
                seperateComment.translatesAutoresizingMaskIntoConstraints = false
                seperateComment.numberOfLines = 0
                nextSeperateComment.translatesAutoresizingMaskIntoConstraints = false
                nextSeperateComment.numberOfLines = 0
                NSLayoutConstraint.activate([
                    seperateComment.topAnchor.constraint(equalTo: commentsArea.topAnchor, constant: labelSpace),
                    seperateComment.leadingAnchor.constraint(equalTo: commentsArea.leadingAnchor),
                    seperateComment.trailingAnchor.constraint(equalTo: commentsArea.trailingAnchor, constant: -margin),
                    nextSeperateComment.topAnchor.constraint(equalTo: seperateComment.bottomAnchor, constant: labelSpace),
                    seperateComment.leadingAnchor.constraint(equalTo: commentsArea.leadingAnchor),
                    seperateComment.trailingAnchor.constraint(equalTo: commentsArea.trailingAnchor, constant: -margin)
                ])
                setSpecialColorText(seperateComment: seperateComment)
                setSpecialColorText(seperateComment: nextSeperateComment)
            }
            guard let comment = commentsArea.subviews.last else { return }
            commentsArea.bottomAnchor.constraint(equalTo: comment.bottomAnchor, constant: labelSpace).isActive = true
        }
    }

    
    func setImageConstraint(count: Int, leftEdge: Float, topEdge: Float, imageWidth: Float, imageHeight: Float) {
        let imageView = contentImage[count]
        imageArea.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: imageArea.leftAnchor, constant: CGFloat(leftEdge)),
            imageView.topAnchor.constraint(equalTo: imageArea.topAnchor, constant: CGFloat(topEdge)),
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(imageWidth)),
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(imageHeight))
        ])
    }
}
