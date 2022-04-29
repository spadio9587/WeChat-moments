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
    let avaterSender = UIImageView()
    let sender = UILabel()
    var containerView = UIStackView()
    var content = UILabel()
    var imageArea = UIView()
    var contentImage = [UIImageView]()
    var commentsArea = UIView()
    var commentsContent = [UILabel]()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(avaterSender)
        self.addSubview(sender)
        self.addSubview(containerView)
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
    func loadImage(from imageUrl: String?) -> UIImage? {
        guard let imageUrl = imageUrl,
              let url = URL(string: imageUrl),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
                  return nil
              }
        return image
    }
    func setTweet(tweet: Tweet) {
        self.tweet = tweet
        sender.text = tweet.sender?.username
        avaterSender.image = loadImage(from: tweet.sender?.avatar)
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
                imageView.image = loadImage(from: images[index].url)
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
                print("\(String(describing: labelView.text))")
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
        avaterSender.clipsToBounds = true
    }
    
    func configureSender() {
        sender.translatesAutoresizingMaskIntoConstraints = false
        sender.leadingAnchor.constraint(equalTo: avaterSender.trailingAnchor, constant: 5).isActive = true
        sender.topAnchor.constraint(equalTo: avaterSender.topAnchor).isActive = true
        sender.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        sender.numberOfLines = 1
        sender.textColor = .systemBlue
        sender.font = UIFont.systemFont(ofSize: 17)
    }
    
    func configureContainerView() {
        containerView.axis = .vertical
        containerView.distribution = .equalSpacing
        containerView.spacing = 8
        containerView.alignment = .leading
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: sender.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        containerView.topAnchor.constraint(equalTo: sender.bottomAnchor, constant: 8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
    func configureContent() {
        containerView.addArrangedSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        content.numberOfLines = 0
        content.backgroundColor = .lightGray
        //content的高度并没有自适应 会重叠起来
    }
    
    func configureImageArea(){
        imageArea.backgroundColor = .orange
        //为什么不显示imageArea的背景颜色
        imageArea.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addArrangedSubview(imageArea)
        //需要把image的数据导入进去
        
        for i in 0...8 {
            let imageView = UIImageView()
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
    
//    func configureContentImage() {
//        let i = contentImage.count
//        switch i {
//        case 1,2,3:
//            for seperateImage in contentImage {
//                print("\(seperateImage.bounds.size.width)")
//                seperateImage.leadingAnchor.constraint(equalTo: imageArea.leftAnchor).isActive = true
//                seperateImage.topAnchor.constraint(equalTo: imageArea.topAnchor, constant: 5).isActive = true
//                seperateImage.widthAnchor.constraint(equalToConstant: 10).isActive = true
//                seperateImage.heightAnchor.constraint(equalToConstant: 10).isActive = true
//                imageArea.addSubview(seperateImage)
//                }
//
//        default: break
//            }
//        }
            
    

    func configureComment() {
//        for seperateComment in commentsContent {
//            seperateComment.backgroundColor = .lightGray
//            containerView.addArrangedSubview(seperateComment)
//            seperateComment.leadingAnchor.constraint(equalTo: imageArea.leadingAnchor,constant: 5).isActive = true
//            seperateComment.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
//            seperateComment.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -5).isActive = true
//            seperateComment.numberOfLines = 0
//        }
        let attributeLabel = UILabel()
        attributeLabel.backgroundColor = .lightGray
        containerView.addArrangedSubview(attributeLabel)
        attributeLabel.translatesAutoresizingMaskIntoConstraints = false
        attributeLabel.numberOfLines = 0
        let mutableAttribString = NSMutableAttributedString(attributedString: NSAttributedString(string: "思骁：我真的会谢", attributes: [.kern: -0.5]))
        mutableAttribString.addAttributes(
          [.foregroundColor: UIColor.blue],
          range: NSRange(location: 0, length: "思骁：".count)
        )
        attributeLabel.attributedText = mutableAttribString
        
        let attributeLabel2 = UILabel()
        attributeLabel2.backgroundColor = .lightGray
        containerView.addArrangedSubview(attributeLabel2)
        attributeLabel2.translatesAutoresizingMaskIntoConstraints = false
        attributeLabel2.numberOfLines = 0
        let mutableAttribString2 = NSMutableAttributedString(attributedString: NSAttributedString(string: "liepng：我真的会谢", attributes: [.kern: -0.5]))
        mutableAttribString2.addAttributes(
          [.foregroundColor: UIColor.blue],
          range: NSRange(location: 0, length: "liepng：".count)
        )
        attributeLabel2.attributedText = mutableAttribString2
    }
}




