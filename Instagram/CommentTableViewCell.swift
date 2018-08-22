//
//  CommentTableViewCell.swift
//  Instagram
//
//  Created by 長谷川良 on 2018/08/17.
//  Copyright © 2018年 ryou.hasegawa. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    weak var owner: UIViewController?
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCommentData(_ commentData: CommentData){
        self.userLabel.text = "\(commentData.name!)"
        self.captionLabel.text="\(commentData.caption!)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: commentData.date!)
        self.dateLabel.text = dateString
        
    }
    
}
