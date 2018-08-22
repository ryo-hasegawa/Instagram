//
//  CommentViewController.swift
//  Instagram
//
//  Created by 長谷川良 on 2018/08/17.
//  Copyright © 2018年 ryou.hasegawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import SVProgressHUD

class CommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var commentArray: [CommentData] = []
    var postdata: PostData!
    // DatabaseのobserveEventの登録状態を表す
    var observing = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        // テーブルセルのタップを無効にする
        tableView.allowsSelection = false
        //CommentTableViewCellの内容を取得する
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        //tableViewに取得した情報を登録する
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        // テーブル行の高さをAutoLayoutで自動調整する
        tableView.rowHeight = UITableViewAutomaticDimension
        // テーブル行の高さの概算値を設定しておく
        // 高さ概算値 = 「縦横比1:1のUIImageViewの高さ(=画面幅)」+「いいねボタン、キャプションラベル、その他余白の高さの合計概算(=100pt)」
        tableView.estimatedRowHeight = UIScreen.main.bounds.width + 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

}
