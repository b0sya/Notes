//
//  FileNotebook.swift
//  Notes
//
//  Created by b0ysa on 29/06/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import Foundation

class FileNotebook {
    
    private(set) var notes = [Note]()
    var getNotes: [Note]{
        return self.notes
    }
    
    public func add(_ note: Note){
        var isDuplicate = false
        for i in notes {
            if i.uid == note.uid {
                isDuplicate = true
                print ("Error!")
                
            }
        }
        if !isDuplicate{
            notes.append(note)
        }
    }
    
    public func remove(with uid: String){
        var isDeleted = false
        for i in 0...notes.count-1 {
            if notes[i].uid == uid {
                notes.remove(at: i)
                isDeleted = true
            }
        }
        if !isDeleted {
            print ("Error! Uid not found")
        }
    }
    
    public func saveToFile(){
        let fManager = FileManager.default
        guard let path = fManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {return}
        let fileURL = path.appendingPathComponent("Notebook.json")
        do{
            let nodesArr = notes.map{
                $0.json
            }
            let data = try JSONSerialization.data(withJSONObject: nodesArr, options: [])
            try data.write(to: fileURL)
        }catch{
            print(error)
        }
    }
    
    public func loadFromFile(){
        let fManager = FileManager.default
        guard let path = fManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {return}
        let fileURL = path.appendingPathComponent("Notebook.json")
        do{
            let data = try Data(contentsOf: fileURL, options: [])
            guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] else {return}
            notes = dict.map{
                Note.parce(json: $0)
            }
        }catch{
            print(error)
        }
        
    }
}
