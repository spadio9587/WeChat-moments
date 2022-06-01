//
//  ViewController.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.
//

import UIKit

class TweetViewController: UIViewController {
    var viewModel = TweetViewModel()
    var testViewModel = ViewModel()
    var headerView = HeaderView()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TweetCell.self, forCellReuseIdentifier: "TweetCell")
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets.zero
        testViewModel.getDataFromUrl()
        self.tableView.reloadData()
        testViewModel.getUserInfo()
        self.headerView.setUserInfo(userInfo: self.testViewModel.userInfo)
//        testViewModel.getDataFromUrl(callback: {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        })
//        testViewModel.getUserInfo(callback: {
//            DispatchQueue.main.async {
//                self.headerView.setUserInfo(userInfo: self.testViewModel.userInfo)
//            }
//        })
        tableView.addSubview(headerView)
    }
}

extension TweetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tweet = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as? TweetCell else {
            return UITableViewCell()
        }
        tweet.setTweet(tweet: testViewModel.tweet[indexPath.row])
        return tweet
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        testViewModel.tweet.count
    }
}
