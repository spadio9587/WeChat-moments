//
//  WebImageCache.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/8/8.
//

import Foundation

class WebImageCache {
    private static var cache: NSCache = NSCache<NSString, NSData>()
    // 外部还是使用原始string，data
    class func getCacheFromUrl(url: String) {
        
    }
    class func readCacheFromUrl(url: NSString) -> NSData? {
        var data: NSData?
        let path: NSString = WebImageCache.getFullCachePathFromUrl(url: url)
        // 从内存缓存读取
        data = cache.object(forKey: url)
        // 从磁盘读取，并写入内存缓存中
        if data == nil {
            if FileManager.default.fileExists(atPath: path as String) {
                do {
                    data = try NSData(contentsOfFile: path as String, options: NSData.ReadingOptions.alwaysMapped)
                } catch {
                    data = nil
                }
            }
            if data != nil {
                cache.setObject(data!, forKey: url)
            }
        } else {
            print("使用内存缓存")
        }

        return data
    }

    class func writeCacheToUrl(url: NSString, data: NSData) {
        // 写入内存缓存
        cache.setObject(data, forKey: url)
        // 写入磁盘缓存
        let path: NSString = WebImageCache.getFullCachePathFromUrl(url: url)
        data.write(toFile: path as String, atomically: true)
    }
    
    class func getCachePathFromUrl(imageUrl: String) {
        let cachePath = NSHomeDirectory().appending("/Caches")
        let url = URL(string: imageUrl)
        if !(FileManager.default.fileExists(atPath: cachePath)) {
            try? FileManager.default.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
        }
    }
    // 设置缓存路径
    class func getFullCachePathFromUrl(url: NSString) -> NSString {
        let cachePath = NSHomeDirectory().appending("/MyCache")
        // url的接口更多！！！（优先使用URL）
        // 可以处理更多的特殊字符
        // bookmark数据类型
        // 先使用string
//        FileManager.default.fileExists(atPath: cachePath)
        if !(FileManager.default.fileExists(atPath: cachePath)) {
            try? FileManager.default.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
        }
        let newCachePath = cachePath.appendingFormat("/%@", url)
        return newCachePath as NSString
    }
}
