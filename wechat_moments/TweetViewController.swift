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
    @IBOutlet var tableView: UITableView!
    var allTweet: [Tweet]?
    override func viewDidLoad() {
        super.viewDidLoad()
        allTweet = viewModel.getAllTweet()
        tableView.register(TweetCell.self, forCellReuseIdentifier: "TweetCell")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TweetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
}

