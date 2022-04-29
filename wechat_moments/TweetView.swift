//
//  TweetView.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.
//

import Foundation
import UIKit

class TweetView: UIView {
    var tweet : Tweet?
    let margin : CGFloat = 8
    let avaterSender = UIImageView()
    let sender = UILabel()
    var containerView = UIStackView()
    var content = UILabel()
    var imageArea = UIView()
    var contentImage = [UIImageView]()
    var commentsArea = UIView()
    var commentsContent = [UILabel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(avaterSender)
        self.addSubview(sender)
        self.addSubview(containerView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureAvaterSender()
        configureSender()
        configureContainerView()
        configureContent()
        configureImageArea()
        configureCommentsArea()
    }
    
    // 命名规范
    // 还要注意解包的使用
    //  将String转成Image
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
            self.avaterSender.image = image
        }
        updateContent(tweet.content)
        updateImages(tweet.images)
        updateComments(tweet.comments)
    }
    
    //依旧是解包，当content内容不为空的时候，不隐藏content的内容
    
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
            for (index,_) in images.enumerated() {
                let imageView = UIImageView()
                loadImage(from: images[index].url) { image in
                    imageView.image = image
                }
                contentImage.append(imageView)
                imageArea.isHidden = false
            }
        }else{
            imageArea.isHidden = true
        }
    }
    
    func updateComments(_ comments: [Comment]?) {
        if let comments = comments {
            for (index,_) in comments.enumerated() {
                let labelView = UILabel()
                labelView.text = comments[index].sender.username + ": " + comments[index].content
                commentsContent.append(labelView)
                commentsArea.isHidden = false
            }
        }else{
            commentsArea.isHidden = true
        }
    }
    
    func configureAvaterSender() {
        avaterSender.translatesAutoresizingMaskIntoConstraints = false
        avaterSender.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        avaterSender.widthAnchor.constraint(equalToConstant: 30).isActive = true
        avaterSender.heightAnchor.constraint(equalToConstant: 30).isActive = true
        avaterSender.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        avaterSender.contentMode = .scaleAspectFill
    }
    
    func configureSender() {
        sender.translatesAutoresizingMaskIntoConstraints = false
        sender.topAnchor.constraint(equalTo: avaterSender.topAnchor).isActive = true
        sender.leadingAnchor.constraint(equalTo: avaterSender.trailingAnchor, constant: 5).isActive = true
        sender.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5).isActive = true
        sender.numberOfLines = 1
        sender.textColor = .systemBlue
        sender.font = UIFont.systemFont(ofSize: 17)
    }
    
    func configureContainerView() {
        containerView.axis = .vertical
        containerView.alignment = .leading
        containerView.distribution = .equalSpacing
        containerView.spacing = 8
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: sender.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        containerView.topAnchor.constraint(equalTo: sender.bottomAnchor, constant: 8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
    func configureContent() {
        containerView.addArrangedSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.numberOfLines = 0
        //content的高度并没有自适应 会重叠起来
    }
    
    func configureImageArea(){
        containerView.addArrangedSubview(imageArea)
        imageArea.translatesAutoresizingMaskIntoConstraints = false
        print("+++++++++\(contentImage.count)")
        if (contentImage.count != 0) {
            for i in 0...(contentImage.count-1) {
                let imageView = contentImage[i]
                imageView.backgroundColor = .blue
                imageArea.addSubview(imageView)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                let width = (containerView.bounds.size.width - 4 * 8) / 3
                let height = width
                let left = CGFloat((i % 3 + 1)) * 8 + CGFloat(i % 3) * width
                let top = CGFloat((i / 3 + 1)) * 8 + CGFloat(i / 3) * height
                NSLayoutConstraint.activate([
                    imageView.leftAnchor.constraint(equalTo: imageArea.leftAnchor, constant: left),
                    imageView.topAnchor.constraint(equalTo: imageArea.topAnchor, constant: top),
                    imageView.widthAnchor.constraint(equalToConstant: width),
                    imageView.heightAnchor.constraint(equalToConstant: height),
                ])
            }
            if let view = imageArea.subviews.last {
                imageArea.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8).isActive = true
            }
        }
    }
    
    func configureCommentsArea(){
        commentsArea.backgroundColor = .orange
        commentsArea.translatesAutoresizingMaskIntoConstraints = false
        containerView.addArrangedSubview(commentsArea)
        //需要把image的数据导入进去
        if (commentsContent.count) != 0 {
            for i in 0...(commentsContent.count - 1) {
                let seperateComment = commentsContent[i]
                commentsArea.addSubview(seperateComment)
                seperateComment.backgroundColor = .lightGray
                seperateComment.translatesAutoresizingMaskIntoConstraints = false
                seperateComment.numberOfLines = 0
                let top = CGFloat((i + 1) * 3) + CGFloat((i - 1) * 5)
                seperateComment.topAnchor.constraint(equalTo: commentsArea.topAnchor, constant: top).isActive = true
                let mutableAttribString = NSMutableAttributedString(attributedString: NSAttributedString(string: seperateComment.text!, attributes: [.kern: -0.5]))
                let str = seperateComment.text!
                let number = str.firstIndex(of: ":")
                let begin = str[..<number!]
                let length = begin.count
                mutableAttribString.addAttributes(
                    [.foregroundColor: UIColor.blue],
                    range: NSRange(location: 0, length: length)
                )
                seperateComment.attributedText = mutableAttribString
                
            }
            if let comment = commentsArea.subviews.last{
                commentsArea.bottomAnchor.constraint(equalTo: comment.bottomAnchor,constant: 8).isActive = true
            }
        }
    }
}





