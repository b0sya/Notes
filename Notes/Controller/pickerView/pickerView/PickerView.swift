//
//  PickerView.swift
//  Notes
//
//  Created by b0ysa on 13/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

@IBDesignable
class PickerView: UIView {
    //MARK: Outlets
    @IBOutlet weak var scope: UIImageView!
    
    var onColorDidChange: ((_ color: UIColor) -> ())?
    
    var brightness: CGFloat = 1.0
    let saturationExponentTop:Float = 2.0
    let saturationExponentBottom:Float = 1.3
    var rectPalette = CGRect.zero
    
    var elementSize: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
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
    
    override func draw(_ rect: CGRect){
        
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        rectPalette = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        
        
        for y in stride(from: CGFloat(0), to: rectPalette.height, by: elementSize) {
            
            var saturation = y < rectPalette.height / 2.0 ? CGFloat(2 * y) / rectPalette.height : 2.0 * CGFloat(rectPalette.height - y) / rectPalette.height
            
            saturation = CGFloat(powf(Float(saturation), y < rectPalette.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
            
            for x in stride(from: (0 as CGFloat), to: rectPalette.width, by: elementSize) {
                let hue = x / rectPalette.width
                
                let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
                
                context!.setFillColor(color.cgColor)
                context!.fill(CGRect(x:x, y: y + rectPalette.origin.y,
                                     width: elementSize, height: elementSize))
            }
        }
    }
    
    func getColorAtPoint(point:CGPoint) -> UIColor {
        let roundedPoint = CGPoint(x:elementSize * CGFloat(Int(point.x / elementSize)),
                                   y:elementSize * CGFloat(Int(point.y / elementSize)))
        var saturation = roundedPoint.y < self.bounds.height / 2.0 ? CGFloat(2 * roundedPoint.y) / self.bounds.height
            : 2.0 * CGFloat(self.bounds.height - roundedPoint.y) / self.bounds.height
        saturation = CGFloat(powf(Float(saturation), roundedPoint.y < self.bounds.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
        let hue = roundedPoint.x / self.bounds.width
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    
    @objc func touchedColor(gestureRecognizer: UILongPressGestureRecognizer){
        
        
        let point = gestureRecognizer.location(in: self)
        let color = getColorAtPoint(point: point)
        
        if(point.x <= self.bounds.width && point.y <= self.bounds.height && point.x >= 0 && point.y >= 0){
            scope.center = CGPoint(x:point.x, y:point.y)
        }
        
        self.onColorDidChange?(color)
    }
    
    private func configure(){
        let touchGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(touchedColor)
        )
        
        touchGesture.minimumPressDuration = 0
        touchGesture.allowableMovement = .greatestFiniteMagnitude
        
        self.addGestureRecognizer(touchGesture)
    }
    
}
