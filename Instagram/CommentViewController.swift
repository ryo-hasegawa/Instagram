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
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        //キーボードの自動起動
        
    }
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        if Auth.auth().currentUser != nil {
            if self.observing == false {
                // 要素が追加されたらpostArrayに追加してTableViewを再表示する
                let commentsRef = Database.database().reference().child(Const.CommentPath).child(postdata.id!)
                commentsRef.observe(.childAdded, with: { snapshot in
                    print("DEBUG_PRINT: .childAddedイベントが発生しました。")
                    
                    // CommentDataクラスを生成して受け取ったデータを設定する
                    if (Auth.auth().currentUser?.uid) != nil {
                        let commentData = CommentData(snapshot: snapshot)
                        self.commentArray.insert(commentData, at: 0)
                        
                        // TableViewを再表示する
                        self.tableView.reloadData()
                    }
                })
                // 要素が変更されたら該当のデータをpostArrayから一度削除した後に新しいデータを追加してTableViewを再表示する
                commentsRef.observe(.childChanged, with: { snapshot in
                    print("DEBUG_PRINT: .childChangedイベントが発生しました。")
                    
                    if (Auth.auth().currentUser?.uid) != nil {
                        // PostDataクラスを生成して受け取ったデータを設定する
                        let commentData = CommentData(snapshot: snapshot)
                        
                        // 保持している配列からidが同じものを探す
                        var index: Int = 0
                        for comment in self.commentArray {
                            if comment.postId == commentData.postId {
                                index = self.commentArray.index(of: comment)!
                                break
                            }
                        }
                        
                        // 差し替えるため一度削除する
                        self.commentArray.remove(at: index)
                        
                        // 削除したところに更新済みのデータを追加する
                        self.commentArray.insert(commentData, at: index)
                        
                        // TableViewを再表示する
                        self.tableView.reloadData()
                    }
                })
                
                // DatabaseのobserveEventが上記コードにより登録されたため
                // trueとする
                observing = true
            }
        } else {
            if observing == true {
                // ログアウトを検出したら、一旦テーブルをクリアしてオブザーバーを削除する。
                // テーブルをクリアする
                commentArray = []
                tableView.reloadData()
                // オブザーバーを削除する
                Database.database().reference().removeAllObservers()
                
                // DatabaseのobserveEventが上記コードにより解除されたため
                // falseとする
                observing = false
            }
    
    }

}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CommentTableViewCell
        cell.setCommentData(commentArray[indexPath.row])
        
        return cell
    }
    
    //投稿ボタンが押された時のアクション
    @IBAction func commentButton(_ sender: Any) {
        //必要なデータを取得しておく
        let time = Date.timeIntervalSinceReferenceDate
        let name = Auth.auth().currentUser?.displayName
        let caption = textField.text!
        let postId = postdata.id!
        
        
        
        let commentRef = Database.database().reference().child(Const.CommentPath).child(postId)
        let commentDic = ["caption": caption, "time": String(time), "name": name!,"postId": postId]
        commentRef.childByAutoId().setValue(commentDic)
        
        
    }
    
    
}
