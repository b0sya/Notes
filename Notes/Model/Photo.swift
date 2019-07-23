//
//  Photo.swift
//  Notes
//
//  Created by b0ysa on 21/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

struct Photo: Equatable {
    
    let image: UIImage
    
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.image == rhs.image
    }
}
