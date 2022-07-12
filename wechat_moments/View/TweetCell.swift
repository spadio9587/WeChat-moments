//
//  TweetCellTableViewCell.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/20.
//

import UIKit

public class TweetCell: UITableViewCell {
    var wechatView: WechatView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        wechatView = WechatView()
        contentView.addSubview(wechatView)
        configureWechatView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureWechatView() {
        wechatView.translatesAutoresizingMaskIntoConstraints = false
        wechatView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        wechatView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        wechatView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        wechatView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    public func setTweet(tweet: Tweet?) {
        guard let tweet = tweet else { return }
        wechatView.setTweet(tweet: tweet)
        layoutIfNeeded()
    }
}
