//
//  TweetView.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.

import Foundation
import UIKit

enum WeConstant {
    // 间隙
    static let margin: CGFloat = 8
    // 双倍间隙
    static let doubleMargin: CGFloat = 16
    // 评论之间的间隙
    static let labelSpace: CGFloat = 5
    // 用户头像的宽，高
    static let avatarFrame: CGFloat = 50
    // 字体
    static let fontSize: CGFloat = 17
    // 评论标注文字相关系数
    static let attCoefficient: CGFloat = -0.5
    // 屏幕宽度
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
}

class WechatView: UIView {
    var tweet: Tweet?
    let avatarSender = UIImageView()
    let sender = UILabel()
    let containerView = UIStackView()
    let content = UILabel()
    let imageArea = UIView()
    let commentsArea = UIView()
    var contentImage = [UIImageView]()
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

    func loadImage(from imageUrl: String?, callback: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            guard let imageUrl = imageUrl,
                  let url = URL(string: imageUrl),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
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
            avatarSender.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: WeConstant.margin),
            avatarSender.widthAnchor.constraint(equalToConstant: WeConstant.avatarFrame),
            avatarSender.heightAnchor.constraint(equalToConstant: WeConstant.avatarFrame),
            avatarSender.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: WeConstant.margin),
        ])
    }

    func configureSender() {
        sender.numberOfLines = 1
        sender.textColor = .systemBlue
        sender.font = UIFont.systemFont(ofSize: WeConstant.fontSize)
        sender.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sender.topAnchor.constraint(equalTo: avatarSender.topAnchor),
            sender.leadingAnchor.constraint(equalTo: avatarSender.trailingAnchor, constant: WeConstant.margin),
            sender.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -WeConstant.margin),
        ])
    }

    func configureContainerView() {
        containerView.axis = .vertical
        containerView.alignment = .leading
        containerView.distribution = .equalSpacing
        containerView.spacing = WeConstant.margin
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addArrangedSubview(content)
        containerView.addArrangedSubview(imageArea)
        containerView.addArrangedSubview(commentsArea)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: sender.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -WeConstant.margin),
            containerView.topAnchor.constraint(equalTo: sender.bottomAnchor, constant: WeConstant.margin),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func configureContent() {
        content.translatesAutoresizingMaskIntoConstraints = false
        content.numberOfLines = 0
        content.lineBreakMode = .byWordWrapping
        content.font = UIFont.systemFont(ofSize: WeConstant.fontSize)
        content.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2 * WeConstant.margin).isActive = true
        if content.text == nil {
            content.isHidden = true
        }
    }

    func configureImageArea() {
        imageArea.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageArea.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        if contentImage.isEmpty == false {
            switch contentImage.count {
            case 1:
                for count in 0 ... (contentImage.count - 1) {
                    let width = (WeConstant.screenWidth - WeConstant.avatarFrame - 3 * WeConstant.margin - 3 - 2 * WeConstant.margin)
                    let height = width * 3 / 4
                    let left = 0
                    let top = 0
                    setImageConstraint(count: count, leftEdge: Float(left), topEdge: Float(top), imageWidth: Float(width), imageHeight: Float(height))
                }
            case 2, 4:
                for count in 0 ... (contentImage.count - 1) {
                    let width = (WeConstant.screenWidth - WeConstant.avatarFrame - 3 * WeConstant.margin - 3 * WeConstant.margin) / 2
                    let height = width
                    let left = CGFloat(count % 2) * WeConstant.margin + CGFloat(count % 2) * width
                    let top = CGFloat(count / 2 + 1) * WeConstant.margin + CGFloat(count / 2) * height
                    setImageConstraint(count: count, leftEdge: Float(left), topEdge: Float(top), imageWidth: Float(width), imageHeight: Float(height))
                }
            default:
                for count in 0 ... (contentImage.count - 1) {
                    let width = (WeConstant.screenWidth - WeConstant.avatarFrame - 3 * WeConstant.margin - 4 * WeConstant.margin) / 3
                    let height = width
                    let left = CGFloat(count % 3) * WeConstant.margin + CGFloat(count % 3) * width
                    let top = CGFloat(count / 3 + 1) * WeConstant.margin + CGFloat(count / 3) * height
                    setImageConstraint(count: count, leftEdge: Float(left), topEdge: Float(top), imageWidth: Float(width), imageHeight: Float(height))
                }
            }
            guard let view = imageArea.subviews.last else { return }
            imageArea.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: WeConstant.margin).isActive = true
        }
    }

    func configureCommentsArea() {
        commentsArea.translatesAutoresizingMaskIntoConstraints = false
        commentsArea.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        commentsArea.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -WeConstant.doubleMargin).isActive = true
        commentsArea.topAnchor.constraint(equalTo: imageArea.bottomAnchor).isActive = true
        commentsArea.backgroundColor = .systemGray6
        if (commentsContent.count) != 0 {
            func setSpecialColorText(seperateComment: UILabel) {
                let mutableAttribString = NSMutableAttributedString(attributedString: NSAttributedString(string: seperateComment.text!, attributes: [.kern: WeConstant.attCoefficient]))
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
                    seperateComment.topAnchor.constraint(equalTo: commentsArea.topAnchor, constant: WeConstant.labelSpace),
                    seperateComment.leadingAnchor.constraint(equalTo: commentsArea.leadingAnchor),
                    seperateComment.trailingAnchor.constraint(equalTo: commentsArea.trailingAnchor, constant: -WeConstant.margin),
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
                    seperateComment.topAnchor.constraint(equalTo: commentsArea.topAnchor, constant: WeConstant.labelSpace),
                    seperateComment.leadingAnchor.constraint(equalTo: commentsArea.leadingAnchor),
                    seperateComment.trailingAnchor.constraint(equalTo: commentsArea.trailingAnchor, constant: -WeConstant.margin),
                    nextSeperateComment.topAnchor.constraint(equalTo: seperateComment.bottomAnchor, constant: WeConstant.labelSpace),
                    seperateComment.leadingAnchor.constraint(equalTo: commentsArea.leadingAnchor),
                    seperateComment.trailingAnchor.constraint(equalTo: commentsArea.trailingAnchor, constant: -WeConstant.margin),
                ])
                setSpecialColorText(seperateComment: seperateComment)
                setSpecialColorText(seperateComment: nextSeperateComment)
            }
            guard let comment = commentsArea.subviews.last else { return }
            commentsArea.bottomAnchor.constraint(equalTo: comment.bottomAnchor, constant: WeConstant.margin).isActive = true
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
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(imageHeight)),
        ])
    }
}
