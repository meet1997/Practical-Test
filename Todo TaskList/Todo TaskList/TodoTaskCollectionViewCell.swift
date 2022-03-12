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
    @IBOutlet weak var cellBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.checkMarkImage.isHidden = true
    }

    @IBAction func taskCompletionButtonPressed(_ sender: Any) { }
    
    func configureCell(from task: Task) {
        self.dateLbl.text = task.date
        self.dayLbl.text = task.day
        self.monthLbl.text = task.month
        self.taskTitleLbl.text = task.title
        if task.isCompleted {
            self.cellBackgroundView?.backgroundColor = #colorLiteral(red: 0.102113411, green: 0.6851140926, blue: 0.7803921569, alpha: 1)
            self.checkMarkImage.isHidden = false
        } else {
            self.backgroundView?.backgroundColor = #colorLiteral(red: 0.5748872844, green: 0.6991559975, blue: 0.7803921569, alpha: 1)
        }
    }
}
