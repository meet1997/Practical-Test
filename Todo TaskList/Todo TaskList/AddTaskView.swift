//
//  AddTaskView.swift
//  Todo TaskList
//
//  Created by Meet Shah on 12/03/22.
//

import UIKit

class AddTaskView: UIView {

    var title: String = ""
    var date = ""
    var month = ""
    var day = ""
    var alert = true
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func taskTitleTextFieldEditingEnded(_ sender: Any) {
        title = (sender as? UITextField)?.text ?? ""
    }
    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        self.isHidden = true
    }
    
    @IBAction func dateValueChanged(_ sender: Any) {
        let components = (sender as! UIDatePicker).calendar.dateComponents([.day, .month, .weekday],
                                                            from: datePicker.date)
        date = "\(components.day ?? 0)"
        let mnth = components.month
        let weekday = components.weekday
        switch weekday {
        case 1:
            day = "Sun"
            break
        case 2:
            day = "Mon"
            break
        case 3:
            day = "Tue"
            break
        case 4:
            day = "Wed"
            break
        case 5:
            day = "Thu"
            break
        case 6:
            day = "Fri"
            break
        case 7:
            day = "Sat"
            break
        default:
            break
        }
        
        switch mnth {
        case 1:
            month = "Jan"
            break
        default:
            break
        }
    }
    
    @IBAction func alertValueChanged(_ sender: Any) {
        alert = (sender as! UISwitch).isOn
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
    }
}
