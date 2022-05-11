//
//  TweetCellTableViewCell.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/20.
//

import UIKit

class TweetCell: UITableViewCell {
    var wechatView: WechatView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        wechatView = WechatView()
        self.contentView.addSubview(wechatView)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        configureWechatView()
    }
    
    func configureWechatView(){
        wechatView.translatesAutoresizingMaskIntoConstraints = false
        wechatView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        wechatView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        wechatView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        wechatView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setTweet(tweet: Tweet?) {
        guard let tweet = tweet else {return}
        wechatView.setTweet(tweet: tweet)
    }
}
