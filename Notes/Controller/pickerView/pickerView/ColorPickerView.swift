//
//  ColorPickerView.swift
//  Notes
//
//  Created by b0ysa on 13/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

@IBDesignable
class ColorPickerView: UIView {
    
    let borderColor = UIColor.black.cgColor
    let borderWidth: CGFloat = 1
    let cornerRadius: CGFloat = 5
    
    private var selectedColor: UIColor! {
        willSet(value){
            colorPreview.backgroundColor = value
            HEXLabel.text = toHexString()
        }
    }
    
    //MARK: Outlets
    @IBOutlet weak var colorView: PickerView!
    @IBOutlet weak var colorPreview: UIView!
    @IBOutlet weak var HEXLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        configure()
    }
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ColorPicker", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    private func sendNotificatino() {
        let nc = NotificationCenter.default
        
        var notificatnion = Notification(name: Notification.Name("pickedColor"))
        notificatnion.userInfo = ["pickedColor": selectedColor!]
        
        nc.post(notificatnion)
    }
    
    private func setupView(){
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(xibView)
    }
    
    func configure(){
        colorView.layer.borderColor = borderColor
        colorView.layer.borderWidth = borderWidth
        colorView.layer.cornerRadius = cornerRadius
        colorPreview.layer.borderColor = borderColor
        colorPreview.layer.borderWidth = borderWidth
        colorPreview.layer.cornerRadius = cornerRadius
        
        selectedColor = .white
        colorView.onColorDidChange = { [weak self] color in
            DispatchQueue.main.async {
                self?.selectedColor = color
            }
            
        }
    }
    
    private func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        selectedColor?.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
    
    //MARK: Actions
    @IBAction func buttonTapped(_ sender: UIButton) {
        sendNotificatino()
        self.isHidden = true
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        colorView.brightness = CGFloat(sender.value)
        colorView.onColorDidChange = { [weak self] color in
            DispatchQueue.main.async {
                self?.selectedColor = color
            }
            
        }
    }
}
