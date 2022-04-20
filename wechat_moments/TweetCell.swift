//
//  TweetCellTableViewCell.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/20.
//

import UIKit

class TweetCell: UITableViewCell {

    var tweet : Tweet?
    override func layoutSubviews() {
        //布局写到这里
        //头像 名称 内容 图片 评论
        //完整地显示所有内容就好
    }
    func setTweet(tweet: Tweet?) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
