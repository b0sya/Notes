//
//  ColorPickerViewController.swift
//  Notes
//
//  Created by b0ysa on 21/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

@IBDesignable
class ColorPickerViewController: UIViewController {

    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        // Do any additional setup after loading the view.
    }
    
    private func sendNotificatino() {
        let nc = NotificationCenter.default
        
        var notificatnion = Notification(name: Notification.Name("pickedColor"))
        notificatnion.userInfo = ["pickedColor": selectedColor!]
        
        nc.post(notificatnion)
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
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        colorView.brightness = CGFloat(sender.value)
        colorView.onColorDidChange = { [weak self] color in
            DispatchQueue.main.async {
                self?.selectedColor = color
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
