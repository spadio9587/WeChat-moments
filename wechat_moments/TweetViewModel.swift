//
//  TweetViewModel.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.
//

import Foundation
import UIKit

class TweetViewModel {
    var tweet : [Tweet] = []
    var userInfo : UserInfo?
    func getDataFromUrl(callback: @escaping () -> Void) {
        let url = URL(string: "https://emagrorrim.github.io/mock-api/moments.json")
        let task = URLSession.shared.dataTask(with: url!) { [self]
            data, _, _ in
            guard let data = data  else {
                return
            }
            do {
                let tweet = self.decodeData(data: data)
                let newTweet = self.filterData(tweet: tweet!)
                self.tweet = newTweet
                callback()
            }
        }
        task.resume()

    }
    func getJson(callback: @escaping () -> Void) {
        let url = URL(string: "https://emagrorrim.github.io/mock-api/moments.json")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                var tweet = try JSONDecoder().decode([Tweet].self, from: data )
                tweet.removeAll(where: {$0.content == nil && $0.images == nil})
                self.tweet = tweet
                callback()
            } catch {
                print(error)
            }
        }
        task.resume()
    }

    func decodeData(data:Data) -> [Tweet]? {
        let tweet = try? JSONDecoder().decode([Tweet].self, from: data)
        return tweet
    }

    func filterData(tweet:[Tweet]) -> [Tweet] {
        self.tweet.removeAll(where: {$0.content == nil && $0.images == nil})
        return tweet
    }

    func getUserInfo(callback: @escaping () -> Void) {
        let url = URL(string: "https://emagrorrim.github.io/mock-api/user/jsmith.json")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let userInfo = try JSONDecoder().decode(UserInfo.self, from: data)
                callback()
                self.userInfo = userInfo
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
