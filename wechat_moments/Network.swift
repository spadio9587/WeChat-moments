//
//  Network.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/5/31.
//

import Foundation

public class HttpNetWork {
    var userInfo: UserInfo?
    public func getTweet(urlString: String, callback: @escaping (([Tweet]?) -> Void)) {
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { data, _, _ in
            guard data != nil else {
                return
            }
            let tweet = self.decodeData(data: data!)
            DispatchQueue.main.async {
                callback(tweet)
            }
        }
        task.resume()
    }

    private func decodeData(data: Data) -> [Tweet]? {
        let tweet = try? JSONDecoder().decode([Tweet].self, from: data)
        return tweet
    }

    public func getUser(urlString: String, callback: @escaping (UserInfo?) -> Void) {
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { data, _, _ in
            guard data != nil else {
                return
            }
            let userInfo = self.decodeInfo(data: data!)
            DispatchQueue.main.async {
                callback(userInfo)
            }
        }
        task.resume()
    }

    private func decodeInfo(data: Data) -> UserInfo? {
        let userInfo = try? JSONDecoder().decode(UserInfo.self, from: data)
        return userInfo
    }
}
