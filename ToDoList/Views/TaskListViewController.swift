//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by Nikita Lukyantsev on 23.10.2022.
//

import UIKit

class TaskListViewController: UIViewController {
    @IBOutlet weak var closedTaskCountLabel: UILabel!
    @IBOutlet weak var tasksCollectionView: UICollectionView!
    @IBOutlet weak var showClosedButton: UIButton!
    
    private var allToDoItems: [ToDoItem] = []
    private var toDoItems: [ToDoItem] = []
    private var closedVisible = false
    
    override func viewDidLoad() {
        tasksCollectionView.register(UINib(nibName: "ToDoCell", bundle: nil), forCellWithReuseIdentifier: "\(ToDoCell.self)")
        tasksCollectionView.delegate = self
        tasksCollectionView.dataSource = self
        
        var toDoItem = ToDoItem(text: "Купить сыр", importance: .common, deadline: nil)
        toDoItem.closeTask()
        allToDoItems.append(toDoItem)
        var toDoItem1 = ToDoItem(text: "Купить сыр", importance: .important, deadline: nil)
        toDoItem1.closeTask()
        allToDoItems.append(toDoItem1)
        var toDoItem2 = ToDoItem(text: "Купить сыр", importance: .important, deadline: Date())
        toDoItem2.closeTask()
        allToDoItems.append(toDoItem2)
        var toDoItem3 = ToDoItem(text: "Купить сыр", importance: .unimportant, deadline: Date())
        toDoItem3.closeTask()
        allToDoItems.append(toDoItem3)
        
        allToDoItems.append(ToDoItem(text: "Тестовое задание", importance: .important, deadline: Date()))
        allToDoItems.append(ToDoItem(text: "Тестовое задание", importance: .important, deadline: nil))
        
        allToDoItems.append(ToDoItem(text: "Лечь спать", importance: .common, deadline: Date()))
        allToDoItems.append(ToDoItem(text: "Лечь спать", importance: .unimportant, deadline: nil))
        
        toDoItems = closedVisible ? allToDoItems : allToDoItems.filter { !$0.isClosed() }
        closedTaskCountLabel.text = "Выполнено - \(allToDoItems.filter { $0.isClosed() }.count)"
        showClosedButton.setTitle(closedVisible ? "Скрыть" : "Показать", for: .normal)
        tasksCollectionView.reloadData()
    }
    
    
    @IBAction func showClosedTasks(_ sender: UIButton) {
        closedVisible.toggle()
        showClosedButton.setTitle(closedVisible ? "Скрыть" : "Показать", for: .normal)
        
        toDoItems = closedVisible ? allToDoItems : allToDoItems.filter { !$0.isClosed() }
        tasksCollectionView.reloadData()
    }
}

extension TaskListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ToDoCell = tasksCollectionView.dequeueReusableCell(withReuseIdentifier: "\(ToDoCell.self)", for: indexPath) as! ToDoCell
        cell.setToDoItem(toDoItems[indexPath.row])
        return cell
    }
}

extension TaskListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tasksCollectionView.bounds.width, height: tasksCollectionView.bounds.width / 8)
    }
}
