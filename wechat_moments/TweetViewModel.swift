//
//  TweetViewModel.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.
//

import Foundation

// task1:读取全部的数据，数据格式为数组
// task2:筛选删除无效数据（error，unknown error, which does not contain a content and images）
struct TweetViewModel {
    func getAllTweet() -> [Tweet]? {
        guard let data = momentAll.data(using: .utf8) else {
            return nil
        }
        var tweet = try? JSONDecoder().decode([Tweet].self, from: data)
        tweet?.removeAll(where: {$0.content == nil && $0.images == nil})
        return tweet
    }
}
