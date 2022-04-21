//
//  TweetCellTableViewCell.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/20.
//

import UIKit

class TweetCell: UITableViewCell {

    var tweet : Tweet?
    var backgroundImageView = UIImageView()
    var avaterSender = UIImageView()
    var nameSender = UILabel()
    var content = UILabel()
    var contentImage = UIImageView()
    var comment = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setTweet(tweet: Tweet?) {
        self.tweet = tweet
    }
    
    override func layoutSubviews() {
        //布局写到这里
        //头像 名称 内容 图片 评论
        //完整地显示所有内容就好
        self.addSubview(avaterSender)
        self.addSubview(nameSender)
        self.addSubview(content)
        self.addSubview(contentImage)
        self.addSubview(comment)
        self.addSubview(backgroundImageView)
        configureAvaterSender()
        configureNameSender()
        configureContent()
        configureContentImage()
        configureComment()
    }
    func getURL(item: String) -> URL {
        let url = URL(string: item)
        return url!
    }
    func configureAvaterSender() {
        avaterSender.contentMode = .scaleAspectFit
        avaterSender.layer.cornerRadius = 10
        //超出父试图的部分就会被裁减
//        let data = getURL(item: (tweet?.sender!.avatar)!)
//        avaterSender.image = UIImage
        avaterSender.image = UIImage.init(named: "testImage")
        avaterSender.frame = CGRect(x: 20, y: 11, width: 34, height: 30)
    }
    func configureNameSender() {
        nameSender.layer.cornerRadius = 10
        nameSender.frame = CGRect(x: 84, y: 15, width: 130, height: 21)
        nameSender.text = tweet?.sender?.nick
        nameSender.textColor = .systemBlue
        nameSender.numberOfLines = 1
    }
    func configureContent() {
        content.textColor = .black
        content.frame = CGRect(x: 34, y: 49, width: 346, height: 28)
        content.text = tweet?.content
        content.numberOfLines = .max
    }
    func configureContentImage(){
        contentImage.contentMode = .scaleAspectFit
        contentImage.clipsToBounds = true
        //超出父试图的部分就会被裁减
//        let data = getURL(item: (tweet?.sender!.avatar)!)
//        avaterSender.image = UIImage
        contentImage.image = UIImage.init(named: "testImage2")
        contentImage.frame = CGRect(x: 62, y: 80, width: 70, height: 70)
    }
    func configureComment(){
        comment.textColor = .black
        comment.backgroundColor = .lightGray
        comment.frame = CGRect(x: 62, y: 161, width: 232, height: 21)
        comment.text = "sender: this is the commens"
        comment.numberOfLines = .max
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
