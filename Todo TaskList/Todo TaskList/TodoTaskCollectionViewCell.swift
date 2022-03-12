//
//  TodoTaskCollectionViewCell.swift
//  Todo TaskList
//
//  Created by Meet Shah on 12/03/22.
//

import UIKit

class TodoTaskCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var taskCompletionBtn: UIButton!
    @IBOutlet weak var checkMarkImage: UIImageView!
    @IBOutlet weak var taskTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }

    @IBAction func taskCompletionButtonPressed(_ sender: Any) {
        
    }
}
