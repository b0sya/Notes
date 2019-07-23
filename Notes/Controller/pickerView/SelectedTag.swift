//
//  File.swift
//  Notes
//
//  Created by b0ysa on 13/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

class SelectedTag: UIView {
    //draw selected tag
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawTag(rect)
    }
    
    private func drawTag(_ rect: CGRect){
        let path = UIBezierPath()
        
        path.lineWidth = 2
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        path.stroke()
    }
}
