//
//  TweetViewModel.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.
//

import Foundation
import UIKit

public class TweetViewModel {
    var tweet: [Tweet] = []
    var userInfo: UserInfo?
    func getDataFromUrl(callback: @escaping () -> Void) {
        let url = URL(string: "https://tw-mobile-xian.github.io/moments-data/tweets.json")
        let task = URLSession.shared.dataTask(with: url!) {
            data, _, _ in
            guard let data = data else { return }
            do {
                let tweet = self.decodeData(data: data)
                let fixTweet = self.filterData(with: tweet!)
                self.tweet = fixTweet
                callback()
            }
        }
        task.resume()
    }

    func decodeData(data: Data) -> [Tweet]? {
        let tweet = try? JSONDecoder().decode([Tweet].self, from: data)
        return tweet
    }

    func filterData(with newTweet: [Tweet]) -> [Tweet] {
        let tweet = newTweet.filter { $0.content != nil || $0.images != nil }
        return tweet
    }

    public func getUserInfo(callback: @escaping () -> Void) {
        let url = URL(string: "https://tw-mobile-xian.github.io/moments-data/user.json")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let userInfo = try JSONDecoder().decode(UserInfo.self, from: data)
                self.userInfo = userInfo
                callback()
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
