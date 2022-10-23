//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Nikita Lukyantsev on 22.10.2022.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTextView.delegate = self
        taskTextView.text = "Что надо сделать?"
        taskTextView.textColor = .lightGray
    }
    
    @IBAction func chooseDate(_ sender: UISwitch) {
        deadlineDatePicker.isHidden = !sender.isOn
        if !sender.isOn {
            dateLabel.isHidden = true
        }
    }
    
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
        dateLabel.isHidden = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateLabel.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func cancelAddingTask(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddTaskViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        saveButton.isEnabled = textView.text.trimmingCharacters(in: [" ", "\n", "\t"]) != ""
        
        var frame = taskTextView.frame
        frame.size.height = taskTextView.contentSize.height
        taskTextView.frame = frame
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if taskTextView.textColor == .lightGray {
            taskTextView.text = ""
            taskTextView.textColor = .black
        }
    }
}
