//
//  PhotoCollectionViewCell.swift
//  Notes
//
//  Created by b0ysa on 21/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        initialSetup()
    }
    
    private func initialSetup() {
        layer.cornerRadius = 2
        clipsToBounds = true
    }
}
