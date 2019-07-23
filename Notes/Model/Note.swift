//
//  Note.swift
//  Notes
//
//  Created by b0ysa on 25/06/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

enum Importance{
    case important
    case notImportant
    case normal
}

struct Note {
    let uid: String
    let title: String
    let content: String
    let color: UIColor
    let importance: Importance
    let selfDestructionDate: Date?
    
    init(uid: String = UUID().uuidString, title: String, content: String, color: UIColor = UIColor.white, selfDestructionDate: Date? = nil, importance: Importance) {
        self.color = color
        self.content = content
        self.selfDestructionDate = selfDestructionDate
        self.title = title
        self.uid = uid
        self.importance = importance
    }

}
