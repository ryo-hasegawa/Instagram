//
//  CommentData.swift
//  Instagram
//
//  Created by 長谷川良 on 2018/08/16.
//  Copyright © 2018年 ryou.hasegawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CommentData: NSObject {
    //投稿のID
    var postId: String?
    //コメントのID
    //var id: String?
    //コメントした者のユーザー名
    var name: String?
    //コメント本文
    var caption: String?
    //日付
    var date: Date?
    //
    init(snapshot: DataSnapshot) {
        //self.postId = snapshot.key
     print(snapshot.value)
    let valueDictionary = snapshot.value as! [String: Any]
        self.postId = valueDictionary["postId"] as? String
        
        self.name = valueDictionary["name"] as? String
        
        self.caption = valueDictionary["caption"] as? String
        
        let time = valueDictionary["time"] as? String
        
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
       
        
    }
    
    
    //init(snapshot: DataSnapshot, myId: String){
    //id = snapshot.key
        
        
        //let valueDictionary = snapshot.value as! [String: Any]
        
        //self.postId = valueDictionary["postId"] as? String
        
        //self.name = valueDictionary["name"] as? String
        
        //self .caption = valueDictionary["caption"] as? String
        
        //let time = valueDictionary["time"] as? String
        //self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
    }

