//
//  GalleryLayout.swift
//  Notes
//
//  Created by b0ysa on 21/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

class GalleryLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        
        guard let collectionView = collectionView else { return }
        
        let insets: CGFloat = 8
        var numberOfColumn = 3
        
        if UIDevice.current.orientation.isLandscape {
            numberOfColumn *= 2
        }
        
        minimumLineSpacing = insets
        minimumInteritemSpacing = insets
        sectionInsetReference = .fromSafeArea
        sectionInset = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
        
        let summaryInsets = insets * (CGFloat(numberOfColumn) + 1)
        let avalibleSpace = (collectionView.bounds.width - summaryInsets).rounded(.down)
        let cellSize = avalibleSpace / CGFloat(numberOfColumn)
        
        
        itemSize = CGSize(width: cellSize, height: cellSize)
    }
}
