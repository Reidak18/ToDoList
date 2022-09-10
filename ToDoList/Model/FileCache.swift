//
//  FileCache.swift
//  ToDoList
//
//  Created by Nikita Lukyantsev on 08.09.2022.
//

import Foundation

class FileCache {
    private(set) var toDoItems: [ToDoItem] = []
    
    func addTask(_ item: ToDoItem) {
        toDoItems.append(item)
    }
    
    func removeTask(id: String) {
        toDoItems.removeAll { $0.id == id }
    }
    
    func saveInFile(fileName: String) {
        
        let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        var dict: [String:String] = [:]
        for (index, item) in toDoItems.enumerated() {
            guard let json = item.json
            else {
                print("Fail to extract json from item id = \(item.id)")
                continue
            }
            guard let convertDataToStr = String(data: json, encoding: .utf8)
            else {
                print("Fail to convert data to string for item id = \(item.id)")
                continue
            }
            dict[String(index)] = convertDataToStr
        }
        
        guard let json = try? JSONSerialization.data(withJSONObject: dict, options: [])
        else {
            print("Can't create json from dictionaty")
            return
        }
        
        do {
            try json.write(to: url)
        }
        catch {
            print("Can't write data in \(url.path)")
            return
        }

    }
    
    func loadFromFile(fileName: String) {
        let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        guard let data = try? Data(contentsOf: url)
        else {
            print("Can't load data from \(url.path)")
            return
        }
        
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:String]
        else {
            print("Can't deserialize data from \(url.path)")
            return
        }
        
        var index = 0
        while true {
            guard let currentDataStr = dict[String(index)]
            else { break }
            
            guard let itemData = currentDataStr.data(using: .utf8)
            else {
                print("Can't convert string to data in element \(index)")
                break
            }
            
            guard let currentItem = ToDoItem.parse(json: itemData)
            else {
                print("Can't parse data \(itemData)")
                break
            }
            
            toDoItems.append(currentItem)
            index += 1
        }
    }
}
