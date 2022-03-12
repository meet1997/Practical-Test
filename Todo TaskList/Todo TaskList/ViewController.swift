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
    
    let cellsInSingleRow: CGFloat = 2
    let cellReuseIdentifier = "taskCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTaskCollectionView.dataSource = self
        todoTaskCollectionView.delegate = self
        todoTaskCollectionView.register(UINib(nibName: "TodoTaskCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: cellReuseIdentifier)
        
        userName.text = UIDevice.current.name
        userImage.image = UIImage(named: "userImage")
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        
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
