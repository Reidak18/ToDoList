//
//  ViewController.swift
//  ToDoList
//
//  Created by Nikita Lukyantsev on 27.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buildLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
//            buildLabel.text = "Version \(appVersion)"
//        }
    }
    
    @IBAction func addTask(_ sender: UIButton) {
        let addTaskVC = TaskListViewController(nibName: "TaskListViewController", bundle: nil)
        self.present(addTaskVC, animated: true, completion: nil)
    }
}

