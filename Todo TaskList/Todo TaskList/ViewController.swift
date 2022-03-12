//
//  ViewController.swift
//  Todo TaskList
//
//  Created by Meet Shah on 12/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var todoTaskCollectionView: UICollectionView!
    @IBOutlet weak var addTaskView: AddTaskView!
    @IBOutlet weak var addTaskViewBottomConstraint: NSLayoutConstraint!
    
    let cellsInSingleRow: CGFloat = 2
    let cellReuseIdentifier = "taskCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTaskCollectionView.dataSource = self
        todoTaskCollectionView.delegate = self
        todoTaskCollectionView.register(UINib(nibName: "TodoTaskCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: cellReuseIdentifier)
        
        userName.text = UIDevice.current.name
        userImage.image = UIImage(named: "userImage")
        addTaskView.clipsToBounds = true
        addTaskView.layer.cornerRadius = 15
        addTaskView.taskTextField.delegate = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        addTaskView.isHidden = false
        
    }
    
    @objc func keyboardWillHide(_ n: Notification) {
        if let keyboardFrame = n.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardFrame.cgRectValue
            print(keyboardFrame.height)
            addTaskViewBottomConstraint.constant -= keyboardFrame.height
        }
    }
    
    @objc func keyboardWillShow(_ n: Notification) {
        if let keyboardFrame = n.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardFrame.cgRectValue
            if(addTaskViewBottomConstraint.constant >= keyboardFrame.height) {
                return
            }
            addTaskViewBottomConstraint.constant += keyboardFrame.height
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = todoTaskCollectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? TodoTaskCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 16
        
        let width = (collectionView.frame.width - spacing) / cellsInSingleRow
        return CGSize(width: width, height: width)
    }
    
}
