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
    func testBuildRequest() {
        // given
        let url = URL(string: "https://emagrorrim.github.io/mock-api/user/jsmith.json")
        // when
        let task = URLSession.shared.dataTask(with: url!)
        // then
        XCTAssertNotNil(task)
        // 此时datatask解析一定有数值，所以此测试无意义
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

    func testTweet() {
        let tweet = Tweet(content: "what happened", images: nil, sender: nil, comments: nil)
        XCTAssertTrue(((tweet.content?.isEmpty) != nil))
    }
}
