//
//  Network.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/5/31.
//

import Foundation

class HttpNetWork {
    var userInfo: UserInfo?
    func get(callback: @escaping () -> Void) {
        let url = URL(string: "https://emagrorrim.github.io/mock-api/moments.json")
        let task = URLSession.shared.dataTask(with: url!) {
            data, _, _ in
            guard data != nil else {
                return
            }
            let userInfo = self.decodeData(data: data!)
            self.userInfo = userInfo
            callback()
        }
        task.resume()
    }
    
    func decodeData(data: Data) -> UserInfo? {
        let userInfo = try? JSONDecoder().decode(UserInfo.self, from: data)
        return userInfo
    }
}
