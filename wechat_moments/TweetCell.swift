//
//  TweetCellTableViewCell.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/20.
//

import UIKit

class TweetCell: UITableViewCell {
//    var tweet: Tweet?
    var tweetView: TweetView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        tweetView = TweetView()
        self.contentView.addSubview(tweetView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        configureTweetView()
    }

    func configureTweetView(){
        tweetView.translatesAutoresizingMaskIntoConstraints = false
        tweetView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        tweetView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        tweetView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tweetView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setTweet(tweet: Tweet?) {
        guard let tweet = tweet else {return}
        tweetView.setTweet(tweet: tweet)
    }
}
