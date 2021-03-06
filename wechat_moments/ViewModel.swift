//
//  ViewModel.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/6/1.
//

import Foundation
import UIKit

public class ViewModel {
    var tweet: [Tweet] = []
    var userInfo: UserInfo?
    var netWork = HttpNetWork()
    public func getDataFromUrl() {
        netWork.getTweet(urlString: "https://emagrorrim.github.io/mock-api/moments.json") { tweet in
            let fixTweet = self.filterData(with: tweet!)
            self.tweet = fixTweet
        }
    }

    private func filterData(with newTweet: [Tweet]) -> [Tweet] {
        let tweet = newTweet.filter { $0.content != nil || $0.images != nil }
        return tweet
    }

    public func getUserInfo() {
        netWork.getUser(urlString: "https://emagrorrim.github.io/mock-api/user/jsmith.json") { userInfo in
            self.userInfo = userInfo
        }
    }
}
