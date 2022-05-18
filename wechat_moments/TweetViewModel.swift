//
//  TweetViewModel.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.
//

import Foundation
import UIKit

// task1:读取全部的数据，数据格式为数组
// task2:筛选删除无效数据（error，unknown error, which does not contain a content and images）
class TweetViewModel {
    var tweet : [Tweet] = []
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
                print(userInfo)
                    callback()
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
