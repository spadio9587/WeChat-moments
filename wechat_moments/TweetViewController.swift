//
//  ViewController.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.
//

import UIKit
class TweetViewController: UIViewController {
    var viewModel = TweetViewModel()
    var headerView = HeaderView()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.register(TweetCell.self, forCellReuseIdentifier: "TweetCell")
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets.zero
        viewModel.getDataFromUrl(callback: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        viewModel.getUserInfo(callback: {
            DispatchQueue.main.async {
                self.headerView.setUserInfo(userInfo: self.viewModel.userInfo)
            }
        })
        tableView.addSubview(headerView)
    }
}

extension TweetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tweet = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as? TweetCell else {
            return UITableViewCell()
        }
        tweet.setTweet(tweet: viewModel.tweet[indexPath.row])
        return tweet
    }
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.tweet.count
    }
}
