//
//  AddTaskView.swift
//  Todo TaskList
//
//  Created by Meet Shah on 12/03/22.
//

import UIKit

protocol TaskDelegate: AnyObject {
    func add(task: Task)
    func cancel()
}

class AddTaskView: UIView {

    var date = ""
    var month = ""
    var day = ""
    var alert = true
    weak var delegate: TaskDelegate?
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alertSwitch: UISwitch!
    
    @IBAction func taskTitleTextFieldEditingEnded(_ sender: Any) { }
    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        self.isHidden = true
        delegate?.cancel()
        resetData()
    }
    
    @IBAction func dateValueChanged(_ sender: Any) {
        setDateValues(sender as! UIDatePicker)
    }
    
    @IBAction func alertValueChanged(_ sender: Any) {
        alert = (sender as! UISwitch).isOn
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        if day == "" && date == "" && month == "" {
            setDateValues(self.datePicker)
        }
        let task = Task(title: taskTextField.text ?? "", date: date, month: month, day: day, alert: alert)
        delegate?.add(task: task)
        taskTextField.resignFirstResponder()
        self.resignFirstResponder()
        self.isHidden = true
        resetData()
    }
    
    func setDateValues(_ picker: UIDatePicker) {
        let components = picker.calendar.dateComponents([.day, .month, .weekday],
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
        case 2:
            month = "Feb"
            break
        case 3:
            month = "Mar"
            break
        case 4:
            month = "Apr"
            break
        case 5:
            month = "May"
            break
        case 6:
            month = "Jun"
            break
        case 7:
            month = "Jul"
            break
        case 8:
            month = "Aug"
            break
        case 9:
            month = "Sep"
            break
        case 10:
            month = "Oct"
            break
        case 11:
            month = "Nov"
            break
        case 12:
            month = "Dec"
            break
        default:
            break
        }
    }
    
    func resetData() {
        taskTextField.text = ""
        datePicker.date = Date()
        alertSwitch.isOn = true
        day = ""
        date = ""
        month = ""
        alert = true
    }
}
