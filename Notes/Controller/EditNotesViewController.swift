//
//  EditNotesViewController.swift
//  Notes
//
//  Created by b0ysa on 09/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

class EditNotesViewController: UIViewController {
    

    //MARK: Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorPicker: ColorPickerView!
    @IBOutlet var colorViews: [ColorView]!
    
    private var lastTappedButton: ColorView!
    var note: Note?
    private var id: String?
    private var storage = AppDelegate.shared.notesStorage

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        colorViews[2].backgroundColor = .red
        colorViews[3].backgroundColor = .white
        colorViews[1].backgroundColor = .green
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if note != nil {
            updateMote()
        } else {
            createNote()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configure() {
        
        if note != nil {
            title = "Editing"
            editNoteMod()
        }else{
            title = "New note"
            createNoteMod()
        }
        
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        datePicker.isHidden = true
        
        registerForKeyboardNotifications()
    }
    
    private func editNoteMod(){
        guard let note = note else {
            return
        }
        switch note.color {
        case .white:
            lastTappedButton = colorViews[3]
            colorViews[3].isPicked = true
        case .red:
            lastTappedButton = colorViews[2]
            colorViews[2].isPicked = true
        case .green:
            lastTappedButton = colorViews[1]
            colorViews[1].isPicked = true
        default:
            lastTappedButton = colorViews[0]
            lastTappedButton.backgroundColor = note.color
            lastTappedButton.isPicked = true
            lastTappedButton.showGradient = false
        }
        
        textField.text = note.title
        textView.text = note.content
        
        if let date = note.selfDestructionDate {
            datePicker.date = date
            switcher.isOn = true
        } else {
            datePicker.isHidden = true
        }
    }
    
    private func createNoteMod() {
        
        id = UUID().uuidString
        
        colorViews[3].isPicked = true
        lastTappedButton = colorViews[3]
        
        datePicker.isHidden = true
    }
    
    func updateMote() {
        guard let note = note, let title = textField.text, let content = textView.text else {return}
        var date: Date?
        if switcher.isOn {
            date = datePicker.date
        }
        let newNote = Note(uid: note.uid, title: title, content: content, color: lastTappedButton.backgroundColor!, selfDestructionDate: date, importance: .normal)
        storage.add(newNote)
        
    }
    
    func createNote() {
        
        guard let id = id,
            let title = textField.text, !title.isEmpty,
            let content = textView.text, !content.isEmpty else { return }
        
        var date: Date?
        
        if switcher.isOn {
            date = datePicker.date
        }
        
        let newNote = Note(
            uid: id,
            title: title,
            content: content,
            color: lastTappedButton.backgroundColor!,
            selfDestructionDate: date,
            importance: .normal
        )
        
        storage.add(newNote)
    }
    
    func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setPickedColor), name: NSNotification.Name("pickedColor"), object: nil)
    }
    
    func switchSelectedTag(_ button: ColorView){
        lastTappedButton.isPicked = false
        button.isPicked = true
        lastTappedButton = button

    }
    
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardRectangle = kbFrameSize.cgRectValue
        bottomConstraint.constant = keyboardRectangle.height - 30
    }
    
    @objc func setPickedColor(notification: Notification) {
        
        guard let color = notification.userInfo?["pickedColor"] as? UIColor else {
            return
        }
        
        lastTappedButton.showGradient = false
        lastTappedButton.backgroundColor = color
    }
    
    //MARK: Actions
    @IBAction func hideDataPicker(_ sender: UISwitch){
        datePicker.isHidden = !sender.isOn
    }
    
    @IBAction func freeSpaceTapped(_ sender: UITapGestureRecognizer) {
        textView.resignFirstResponder()
        textField.resignFirstResponder()
    }
    
    @IBAction func showColorPicker(_ sender: UITapGestureRecognizer) {
        colorPicker.isHidden = false
        colorViews[0].showGradient = false
        switchSelectedTag(colorViews[0])
    }
    
    @IBAction func secondButtonTapped(_ sender: UITapGestureRecognizer) {
        switchSelectedTag(colorViews[1])

    }
    
    @IBAction func thirdButtonTapped(_ sender: UITapGestureRecognizer){
        switchSelectedTag(colorViews[2])

    }
    
    @IBAction func fourthButtonTapped(_ sender: UITapGestureRecognizer){
        switchSelectedTag(colorViews[3])
        
    }
    


}
