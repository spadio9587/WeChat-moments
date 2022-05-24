//
//  wechat_momentsTests.swift
//  wechat_momentsTests
//
//  Created by Sixiao He on 2022/4/19.
//

import XCTest
@testable import wechat_moments

class WechatMomentsTests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testDecodeURL() {
        // given
        let viewModel = TweetViewModel()
        let url = URL(string: "https://emagrorrim.github.io/mock-api/moments.json")
        let userUrl = URL(string: "https://emagrorrim.github.io/mock-api/user/jsmith.json")
        // when
        let task = URLSession.shared.dataTask(with: url!) {
            data, _, _ in
            guard let data = data else {
                return
            }
            let tweet = viewModel.decodeData(data: data)
        // then
            XCTAssertNotNil(tweet)
        }
        task.resume()
        let userTask = URLSession.shared.dataTask(with: userUrl!) {
            data, _, _ in
            guard let data = data else {
                return
            }
            let userInfo = viewModel.decodeData(data: data)
        // then
            XCTAssertNil(userInfo)
        }
        userTask.resume()
    }
    // 使用框架，nimble
    func testFilterData() {
        // given
        let viewModel = TweetViewModel()
        let url = URL(string: "https://emagrorrim.github.io/mock-api/moments.json")
        // when
        let task = URLSession.shared.dataTask(with: url!) {
            data, _, _ in
            guard let data = data else {
                return
            }
        // then
            let tweet = viewModel.decodeData(data: data)
            XCTAssertEqual(tweet?.count, 22)
            let filterData = viewModel.filterData(tweet: tweet!)
            XCTAssertEqual(filterData.count, 15)
        }
        task.resume()
    }
    func testWechatView() {
        // given
        // when
        let wechatView = WechatView()
        let text = wechatView.sender
        let avatarSender = wechatView.avatarSender
        let containerView = wechatView.containerView
        let content = wechatView.content
        let imageArea = wechatView.imageArea
        // then
        XCTAssertNotNil(text)
        XCTAssertNotNil(avatarSender)
        XCTAssertNotNil(containerView)
        XCTAssertNotNil(content)
        XCTAssertNotNil(imageArea)
    }
}
