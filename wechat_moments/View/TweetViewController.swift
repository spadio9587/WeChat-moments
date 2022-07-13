//
//  ViewController.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.
//

import UIKit

class TweetViewController: UIViewController, WechatViewDelegate {
    func didTapImageView(at index: Int) {
        imageViewController.index = index
        self.navigationController?.pushViewController(imageViewController, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    private let imageViewController = ImageViewController()
    private let viewModel = TweetViewModel()
//    private let testViewModel = ViewModel()
    private let headerView = HeaderView()
    @IBOutlet var tableView: UITableView!
    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tableView.register(TweetCell.self, forCellReuseIdentifier: "TweetCell")
        tableView.dataSource = self
        tableView.estimatedRowHeight = 500
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
        guard let tweetCell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as? TweetCell else {
            return UITableViewCell()
        }
        tweetCell.wechatView.delegate = self
        tweetCell.wechatView.index = indexPath.row
        tweetCell.setTweet(tweet: viewModel.tweet[indexPath.row])
        return tweetCell
    }

     func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.tweet.count
    }
}
