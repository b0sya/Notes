//
//  NoteExtension.swift
//  Notes
//
//  Created by b0ysa on 28/06/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//
import UIKit

extension Note {
    
    var json: [String: Any] {
        get {
            var lib = [String: Any]()
            lib["title"] = self.title
            lib["uid"] = self.uid
            if self.color != UIColor.white {
                lib["color"] = self.color.toHexString()
            }
            if self.importance != .normal {
                switch self.importance {
                case .important:
                    lib["importance"] = 1
                case .notImportant:
                    lib["importance"] = 0
                default:
                    break
                }
            }
            lib["content"] = self.content
            lib["selfDestructionDate"] = self.selfDestructionDate?.timeIntervalSince1970
            return lib
        }
    }
    
    static func parce(json: [String: Any]) -> Note?{
        
        guard let JSONtitle = json["title"] as? String else {
            return nil
        }
        
        guard let JSONcontent = json["content"] as? String else {
            return nil
        }
        
        guard let JSONuid = json["uid"] as? String else {
            return nil
        }
        
        var JSONimportance = Importance.normal
        if let importance = json["importance"] as? Int {
            switch importance {
            case 1:
                JSONimportance = Importance.important
            case 0:
                JSONimportance = Importance.notImportant
            default:
                break
            }
        }
        
        var JSONcolor = UIColor.white
        if let color = json["color"] as? String {
            JSONcolor = UIColor(hexString: color)
        }
        
        
        var JSONselfDestructionDate:Date?
        if let selfDestructionDate = json["selfDestructionDate"] as? TimeInterval {
            JSONselfDestructionDate = Date(timeIntervalSince1970: selfDestructionDate)
        }else{
            JSONselfDestructionDate = nil
        }
        
        return Note(uid: JSONuid,
                    title: JSONtitle,
                    content: JSONcontent,
                    color: JSONcolor,
                    selfDestructionDate: JSONselfDestructionDate,
                    importance: JSONimportance)
    }
    
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}
