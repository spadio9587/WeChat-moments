//
//  WebImageCache.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/8/8.
//

import Foundation

class WebImageCache {
    private static var cache: NSCache = NSCache<NSString, NSData>()

    class func readCacheFromUrl(url: NSString) -> NSData? {
        var data: NSData?
        let path: NSString=WebImageCache.getFullCachePathFromUrl(url: url)
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
            print("命中内存缓存")
        }

        return data
    }

    class func writeCacheToUrl(url: NSString, data: NSData) {
        // 写入内存缓存
        cache.setObject(data, forKey: url)

        // 写入磁盘缓存
        let path: NSString=WebImageCache.getFullCachePathFromUrl(url: url)
        print(data.write(toFile: path as String, atomically: true))
    }

    // 设置缓存路径
    class func getFullCachePathFromUrl(url: NSString) -> NSString {
        var cachePath=NSHomeDirectory().appending("/Library/Caches/MyCache")
        let fileManager: FileManager=FileManager.default
        fileManager.fileExists(atPath: cachePath)
        if !(fileManager.fileExists(atPath: cachePath)) {
            try? fileManager.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
        }
        // 进行字符串处理
        var newURL: NSString
        newURL=WebImageCache.stringToString(str: url)
        cachePath=cachePath.appendingFormat("/%@", newURL)
        return cachePath as NSString
    }

    // 删除缓存
    class func removeAllCache() {
        let cachePath=NSHomeDirectory().appendingFormat("/Library/Caches/MyCache")
        let fileManager: FileManager=FileManager.default
        if fileManager.fileExists(atPath: cachePath) {
            try? fileManager.removeItem(atPath: cachePath)
        }

    }

    class func stringToString(str: NSString) -> NSString {
        let newStr: NSMutableString=NSMutableString()
        for i in 0...str.length-1 {
            let c: unichar=str.character(at: i)
            if (c>=48&&c<=57)||(c>=65&&c<=90)||(c>=97&&c<=122) {
                newStr.appendFormat("%c", c)
            }
        }
        return newStr.copy() as! NSString
    }
}
