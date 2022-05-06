//
//  ViewController.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/19.
//

import UIKit

// Task1：在viewModel里面解析json数据
// Task2: viewController获取解析后的数据

class TweetViewController: UIViewController {
    let viewModel = TweetViewModel()
    let headerView = HeaderView()
    @IBOutlet var tableView: UITableView!
    var allTweet: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allTweet = viewModel.getAllTweet()
        tableView.register(TweetCell.self, forCellReuseIdentifier: "TweetCell")
        tableView.dataSource = self
//        tableView.estimatedRowHeight = 0
//        tableView.estimatedSectionFooterHeight = 0
//        tableView.estimatedSectionHeaderHeight = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        //估计高度，帮助提高性能
        //表单的高度大多数是固定的
        //表单高度有可能是不固定的（textview多行）（textfield单行）
        view.addSubview(headerView)
    }

}
extension TweetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let tweet = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as? TweetCell else {
//            return UITableViewCell()
//        }
        guard let tweet = tableView.cellForRow(at: indexPath) as? TweetCell else{
            return UITableViewCell()
        }
        
        tweet.setTweet(tweet: allTweet?[indexPath.row])
        return tweet
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweet!.count
    }
}

