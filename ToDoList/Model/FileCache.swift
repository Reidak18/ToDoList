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
        
        var dict: [Int:Data] = [:]
        for (index, item) in toDoItems.enumerated() {
            dict[index] = item.json
        }
        
        guard let json = try? JSONSerialization.data(withJSONObject: dict, options: [])
        else { return }
        
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
        
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [Int:Data]
        else {
            print("Can't deserialize data from \(url.path)")
            return
        }
        
        var index = 0
        while true {
            guard let currentData = dict[index]
            else { break }
            
            guard let currentItem = ToDoItem.parse(json: currentData)
            else { break }
            
            toDoItems.append(currentItem)
            index += 1
        }
    }
}
