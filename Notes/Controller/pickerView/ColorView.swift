//
//  ColorView.swift
//  Notes
//
//  Created by b0ysa on 13/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

@IBDesignable
class ColorView: UIView {
    //class for colored squares
    private let borderWidth: CGFloat = 1
    private let borderColor = UIColor.black.cgColor
    private let cornerRadius: CGFloat = 30
    private let gradientLayer = CAGradientLayer()
    let selectedTag = SelectedTag()
    
    @IBInspectable var showGradient: Bool = false {
        willSet(value) {
            gradientLayer.isHidden = !value
        }
    }
    
    var isPicked: Bool = false {
        willSet(value) {
            selectedTag.isHidden = !value
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        isPicked = false
        setGradient()
        
        selectedTag.backgroundColor = .clear
        selectedTag.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        selectedTag.center = CGPoint(
            x: CGFloat(bounds.height / 2),
            y: CGFloat(bounds.width / 2)
        )
        
        insertSubview(selectedTag, at: 1)
        
    }
    
    private func setGradient() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.red.cgColor,
                                UIColor.yellow.cgColor,
                                UIColor.green.cgColor,
                                UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
