//
//  ImageCache.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/8/8.
//

import UIKit

extension UIImageView {
    func setWebImage(url: NSString?, isCache: Bool) {
        guard let url = url else {
            return
        }
        if isCache {
            let data = WebImageCache.readCacheFromUrl(url: url)
            if data != nil {
                guard let data = data else {
                    return
                }
                let image = UIImage(data: data as Data)
                self.image = image
            } else {
                DispatchQueue.global().async {
                    let URL = NSURL(string: url as String)!
                    // 磁盘缓存拿数据
                    let data = NSData(contentsOf: URL as URL)
                    if data != nil {
                        let image = UIImage(data: data! as Data)
                        WebImageCache.writeCacheToUrl(url: url, data: data!)
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            }
        } else {
            DispatchQueue.global().async {
                let URL = NSURL(string: url as String)!
                let data = NSData(contentsOf: URL as URL)
                if data != nil {
                    guard let data = data else {
                        return
                    }
                    let image = UIImage(data: data as Data)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
