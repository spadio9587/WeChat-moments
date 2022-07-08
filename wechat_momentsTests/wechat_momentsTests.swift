//
//  wechat_momentsTests.swift
//  wechat_momentsTests
//
//  Created by Sixiao He on 2022/4/19.
//

@testable import wechat_moments
import XCTest

class WechatMomentsTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeURL() {
        // given
        let data =
            """
            [
              {
                "content": "沙发！",
                "images": [
                  {
                    "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/001.jpeg"
                  },
                  {
                    "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/002.jpeg"
                  },
                  {
                    "url": "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/003.jpeg"
                  }
                ],
                "sender": {
                  "username": "cyao",
                  "nick": "Cheng Yao",
                  "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/001.jpeg"
                },
                "comments": [
                  {
                    "content": "Good.Good.Good.Good.Good.Good.Good.Good.Good.Good.Good.⏰",
                    "sender": {
                      "username": "leihuang",
                      "nick": "Lei Huang",
                      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/002.jpeg"
                    }
                  },
                  {
                    "content": "Like it too",
                    "sender": {
                      "username": "weidong",
                      "nick": "WeiDong Gu",
                      "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/003.jpeg"
                    }
                  }
                ]
              }]
            """
        let testData = data.data(using: .utf8)
        let viewModel = TweetViewModel()
        guard let tweet = viewModel.decodeData(data: testData!) else {
            return
        }
        // then
        for tweet in tweet {
            XCTAssertEqual(tweet.sender?.username, "cyao")
            XCTAssertEqual(tweet.content, "沙发！")
            XCTAssertEqual(tweet.comments?.count, 2)
        }
        XCTAssertNotNil(tweet)
    }

    func testFilterData() {
        // given
        let viewModel = TweetViewModel()
        let data =
            """
            [
                {
                  "content": "第12条",
                  "sender": {
                    "username": "xinguo",
                    "nick": "Xin Guo",
                    "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/001.jpeg"
                  }
                },
              {
                "sender": {
                  "username": "xinge",
                  "nick": "Xin Ge",
                  "avatar": "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/000.jpeg"
                }
              },
              {
                "error": "illegal"
              },
              {
                "error": "WTF"
              },
              {
                "error": "WOW"
              }]
            """
        let testData = data.data(using: .utf8)
        guard let tweet = viewModel.decodeData(data: testData!) else {
            return
        }
        XCTAssertEqual(tweet.count, 5)
        let filterData = viewModel.filterData(with: tweet)
        XCTAssertEqual(filterData.count, 1)
        for tweet in filterData {
            XCTAssertEqual(tweet.content, "第12条")
            XCTAssertEqual(tweet.sender?.username, "xinguo")
            XCTAssertEqual(tweet.sender?.avatar, "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/001.jpeg")
        }
    }

    func testWechatView() {
        // given
        // when
//        let wechatView = WechatView()
//        let text = wechatView.sender
//        let avatarSender = wechatView.avatarSender
//        let containerView = wechatView.containerView
//        let content = wechatView.content
//        let imageArea = wechatView.imageArea
//        // then
//        XCTAssertNotNil(text)
//        XCTAssertNotNil(avatarSender)
//        XCTAssertNotNil(containerView)
//        XCTAssertNotNil(content)
//        XCTAssertNotNil(imageArea)
    }
}
