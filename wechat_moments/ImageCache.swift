//
//  ImageCache.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/8/8.
//

import Foundation
import UIKit

extension UIImageView {
    func setWebImage(url: NSString?, isCache: Bool) {
        var image: UIImage?
        if url == nil {
            return
        }

        if isCache {
            let data: NSData? = WebImageCache.readCacheFromUrl(url: url!)
            if data != nil {
                image = UIImage(data: data! as Data)
                    self.image = image
            } else {
                DispatchQueue.global().async {
                    let URL: NSURL = .init(string: url! as String)!
                    // 磁盘缓存拿数据
                    let data: NSData? = NSData(contentsOf: URL as URL)
                    if data != nil {
                        image = UIImage(data: data! as Data)
                        WebImageCache.writeCacheToUrl(url: url!, data: data!)
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            }
        } else {
            DispatchQueue.global().async {
                let URL: NSURL = .init(string: url! as String)!
                let data: NSData? = NSData(contentsOf: URL as URL)
                if data != nil {
                    image = UIImage(data: data! as Data)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
