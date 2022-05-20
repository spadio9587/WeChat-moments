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
