//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Nikita Lukyantsev on 06.09.2022.
//

import Foundation

struct ToDoItem {
    enum Importance: String {
        case unimportant
        case common
        case important
    }
    
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    
    init(text: String, importance: Importance, deadline: Date? = nil) {
        self.init(id: UUID().uuidString, text: text, importance: importance, deadline: deadline)
    }
    
    init(id: String, text: String, importance: Importance, deadline: Date? = nil) {
        self.id = id
        self.text = text
        self.importance = importance
        self.deadline = deadline
    }
}

extension ToDoItem {
    static func parse(json: Data) -> ToDoItem? {
        guard let dict = try? JSONSerialization.jsonObject(with: json, options: []) as? [String:Any]
        else { return nil }
        
        // извлекаем из словаря значения полей
        guard let id = dict["id"] as? String,
              let text = dict["text"] as? String
        else { return nil }
        
        // преобразовываем dict["importance"] в Importance, если nil, задаем .common
        let importance: Importance
        if let importanceAny = dict["importance"] {
            guard let importanceStr = importanceAny as? String,
                  let importanceIsValid = Importance(rawValue: importanceStr)
            else { return nil }
            
            importance = importanceIsValid
        }
        else {
            importance = .common
        }

        // преобразовываем dict["deadline"] в Date (в json в виде мс с 1970),
        // если nil, оставляем nil
        let deadline: Date?
        if let deadlineAny = dict["deadline"] {
            guard let deadlineMS = deadlineAny as? Double
            else { return nil }
            
            deadline = Date(timeIntervalSince1970: deadlineMS)
        }
        else {
            deadline = nil
        }
        
        return ToDoItem(id: id, text: text, importance: importance, deadline: deadline)
    }
    
    var json: Data? {
        var dict: [String:Any] = [:]
        dict["id"] = self.id
        dict["text"] = self.text
        if importance != .common {
            dict["importance"] = importance.rawValue
        }
        if let unwDeadline = deadline {
            let doubleInverval: Double = unwDeadline.timeIntervalSince1970
            dict["deadline"] = doubleInverval
        }
        
        guard let json = try? JSONSerialization.data(withJSONObject: dict, options: [])
        else { return nil }
        
        return json
    }
}
