//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Nikita Lukyantsev on 28.10.2022.
//

import UIKit

class ToDoCell: UICollectionViewCell {
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var deadlineView: UIStackView!
    @IBOutlet weak var deadlineDateLabel: UILabel!
    @IBOutlet weak var importantSign: UIImageView!
    
    func setToDoItem(_ task: ToDoItem) {
        if task.isClosed() {
            taskNameLabel.attributedText = NSAttributedString(string: task.text, attributes: [.strikethroughStyle : NSUnderlineStyle.single.rawValue])
            taskNameLabel.textColor = .lightGray
            statusImage.image = UIImage(systemName: "checkmark.circle.fill")
            statusImage.tintColor = .green
        }
        else {
            taskNameLabel.attributedText = NSAttributedString(string: task.text, attributes: nil)
            taskNameLabel.textColor = .black
            statusImage.image = UIImage(systemName: "circle")
            statusImage.tintColor = task.importance == .important ? .red : .gray
        }

        if let deadline = task.deadline {
            deadlineView.isHidden = false
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            deadlineDateLabel.text = dateFormatter.string(from: deadline)
        }
        else {
            deadlineView.isHidden = true
        }
        
        importantSign.isHidden = task.importance != .important
    }
}
