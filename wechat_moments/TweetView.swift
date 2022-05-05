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
    
    //初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(avaterSender)
        self.addSubview(sender)
        self.addSubview(containerView)
        configureContainerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureAvaterSender()
        configureSender()
        configureContent()
        configureImageArea()
        configureCommentsArea()
    }
    
    // 命名规范
    // 还要注意解包的使用
    //  将String转成Image
    //异步加载图片并callback到主线程里面来
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
        //尾随闭包
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
        avaterSender.contentMode = .scaleAspectFill
        avaterSender.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avaterSender.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 10),
            avaterSender.widthAnchor.constraint(equalToConstant: 30),
            avaterSender.heightAnchor.constraint(equalToConstant: 30),
            avaterSender.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
        ])
        
    }
    
    func configureSender() {
        sender.numberOfLines = 1
        sender.textColor = .systemBlue
        sender.font = UIFont.systemFont(ofSize: 17)
        sender.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sender.topAnchor.constraint(equalTo: avaterSender.topAnchor),
            sender.leadingAnchor.constraint(equalTo: avaterSender.trailingAnchor, constant: 5),
            sender.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
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
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -margin),
        ])
    }
    
    func configureContent() {
       
        content.translatesAutoresizingMaskIntoConstraints = false
        content.numberOfLines = 0
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            content.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 5),
        ])
        if content.text == nil {
            content.isHidden = true
        }
        //content的高度并没有自适应 会重叠起来
    }
    
    func configureImageArea(){
        imageArea.translatesAutoresizingMaskIntoConstraints = false
        imageArea.translatesAutoresizingMaskIntoConstraints  = false
        imageArea.topAnchor.constraint(equalTo: content.bottomAnchor,constant: 5).isActive = true
        imageArea.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imageArea.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        if (contentImage.count > 9){
            imageArea.isHidden = true
        }
        if (contentImage.count != 0) {
            for i in 0...(contentImage.count-1) {
                let imageView = contentImage[i]
                imageArea.addSubview(imageView)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                let width = (containerView.bounds.size.width - 4 * margin) / 3
                let height = width
                let left = CGFloat((i % 3 + 1)) * margin + CGFloat(i % 3) * width
                let top = CGFloat((i / 3 + 1)) * margin + CGFloat(i / 3) * height
                NSLayoutConstraint.activate([
                    imageView.leftAnchor.constraint(equalTo: imageArea.leftAnchor, constant: left),
                    imageView.topAnchor.constraint(equalTo: imageArea.topAnchor, constant: top),
                    imageView.widthAnchor.constraint(equalToConstant: width),
                    imageView.heightAnchor.constraint(equalToConstant: height),
                ])
            }
            
        }else{
            imageArea.isHidden = true
        }
        if let view = imageArea.subviews.last {
            imageArea.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: margin).isActive = true
        }
    }
    
    func configureCommentsArea(){
        commentsArea.translatesAutoresizingMaskIntoConstraints = false
        commentsArea.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        commentsArea.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        commentsArea.topAnchor.constraint(equalTo: imageArea.bottomAnchor,constant: 5).isActive = true
        //需要把image的数据导入进去
        if (commentsContent.count) != 0 {
            for i in 0...(commentsContent.count - 1) {
                let seperateComment = commentsContent[i]
                commentsArea.addSubview(seperateComment)
                seperateComment.backgroundColor = .lightGray
                seperateComment.translatesAutoresizingMaskIntoConstraints = false
                seperateComment.numberOfLines = 0
                //计算单条评论的高度
                let top = CGFloat((i + 1) * 5) + CGFloat(CGFloat((i)) * CGFloat(seperateComment.bounds.size.height))
                NSLayoutConstraint.activate([
                    seperateComment.topAnchor.constraint(equalTo: commentsArea.topAnchor, constant: top),
                ])
                let mutableAttribString = NSMutableAttributedString(attributedString: NSAttributedString(string: seperateComment.text!, attributes: [.kern: -0.5]))
                let number = seperateComment.text!.firstIndex(of: ":")
                mutableAttribString.addAttributes(
                    [.foregroundColor: UIColor.blue],
                    range: NSRange(location: 0, length: seperateComment.text![..<number!].count)
                )
                seperateComment.attributedText = mutableAttribString
                
            }
            
        }else{
            commentsArea.isHidden = true
        }
        if let comment = commentsArea.subviews.last{
            commentsArea.bottomAnchor.constraint(equalTo: comment.bottomAnchor,constant: margin).isActive = true
        }
    }
}





