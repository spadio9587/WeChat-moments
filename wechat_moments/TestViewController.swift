//
//  TestViewController.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/4/27.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var tweetView: TweetView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let vm = TweetViewModel()
        
        tweetView.getTweet(tweet: (vm.getAllTweet()?.last)!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
