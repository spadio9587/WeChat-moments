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
    var backgroundImageView = UIImageView()
    @IBOutlet var tableView: UITableView!
    var allTweet: [Tweet]?
    override func viewDidLoad() {
        super.viewDidLoad()
        allTweet = viewModel.getAllTweet()
        tableView.register(TweetCell.self, forCellReuseIdentifier: "TweetCell")
        tableView.dataSource = self
        tableView.rowHeight = 190
        view.addSubview(backgroundImageView)
        configureBackgroundImageView()
        func configureBackgroundImageView(){
            backgroundImageView.contentMode = .scaleAspectFit
            backgroundImageView.image = UIImage.init(named: "testImage3")
            backgroundImageView.frame = CGRect(x: 0, y: -44, width: 414, height: 403)
        }
    }
}
extension TweetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tweet = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as? TweetCell else {
            return UITableViewCell()
        }
        //item没有传进来！
        tweet.setTweet(tweet: allTweet?[indexPath.row])
        return tweet
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweet!.count
    }
}

