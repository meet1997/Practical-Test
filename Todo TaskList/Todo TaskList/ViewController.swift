//
//  ViewController.swift
//  Todo TaskList
//
//  Created by Meet Shah on 12/03/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var todoTaskCollectionView: UICollectionView!
    @IBOutlet weak var addTaskView: AddTaskView!
    @IBOutlet weak var addTaskViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var opaqueView: UIView!
    let cellsInSingleRow: CGFloat = 2
    let cellReuseIdentifier = "taskCell"
    var tasks: [Task] = []
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        todoTaskCollectionView.dataSource = self
        todoTaskCollectionView.delegate = self
        todoTaskCollectionView.register(UINib(nibName: "TodoTaskCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: cellReuseIdentifier)
        
        userName.text = UIDevice.current.name
        userImage.image = UIImage(named: "userImage")
        addTaskView.clipsToBounds = true
        addTaskView.layer.cornerRadius = 15
        addTaskView.taskTextField.delegate = self
        addTaskView.delegate = self
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        loadContext()
        calculateProgress()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        addTaskView.isHidden = false
        opaqueView.isHidden = false
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
    
    func calculateProgress() {
        let numberOfTasks = tasks.count
        if numberOfTasks == 0 {
            progressView.progress = 0
            progressLabel.text = "0%"
            return
        }
        let completedTasks = tasks.filter({ $0.isCompleted }).count
        let value = (Float(completedTasks) / Float(numberOfTasks))
        let percentage = value * 100
        progressView.progress = value
        progressLabel.text = "\(Int(floor(percentage)))%"
    }
    
    func saveContext() {
         do {
             try context.save()
         } catch {
             print("Failed to with error: \(error)")
         }
     }
    
    func loadContext() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            tasks = try context.fetch(request)
            todoTaskCollectionView.reloadData()
        } catch {
            print(error.localizedDescription)
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
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = todoTaskCollectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? TodoTaskCollectionViewCell else {
            return UICollectionViewCell()
        }
        let task = tasks[indexPath.row]
        cell.configureCell(from: task)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        tasks[indexPath.row].isCompleted = true
        saveContext()
        todoTaskCollectionView.reloadItems(at: [indexPath])
        calculateProgress()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 16
        
        let width = (collectionView.frame.width - spacing) / cellsInSingleRow
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

extension ViewController: TaskDelegate {
    func add(task: Task) {
        
        saveContext()
        opaqueView.isHidden = true
        tasks.append(task)
        calculateProgress()
        todoTaskCollectionView.reloadData()
    }
    
    func cancel() {
        opaqueView.isHidden = true
    }
}
