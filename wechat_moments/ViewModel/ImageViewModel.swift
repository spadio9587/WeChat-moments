//
//  ImageViewModel.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/14.
//

import UIKit

public class ImageViewModel {
    var tweet: [Tweet] = []
    // 需要的是图片显示数组的内容
    // 图片点击的index的内容
    // 将这两个内容传递给ImageViewController进行显示
    func getDataFromUrl(callback: @escaping () -> Void) {
        let url = URL(string: "https://emagrorrim.github.io/mock-api/moments.json")
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
}
