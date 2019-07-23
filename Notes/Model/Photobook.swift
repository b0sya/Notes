//
//  File.swift
//  Notes
//
//  Created by b0ysa on 21/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

class Photobook{
    
    private(set) var photos = [Photo]()
    
    func add(_ photo: Photo) {
        photos.insert(photo, at: 0)
    }
}
