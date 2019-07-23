//
//  NotesViewController.swift
//  Notes
//
//  Created by b0ysa on 19/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    private var storage = AppDelegate.shared.notesStorage

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .fade)
    }
    
    private func registerCells(){
        let notesCell = UINib.init(nibName: "NotesTableViewCell", bundle: nil)
        tableView.register(notesCell, forCellReuseIdentifier: "notesCell")
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editSegue", sender: self)
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        
        if tableView.isEditing {
            editButton.title = "Cancel"
            addButton.isEnabled = false
        } else {
            editButton.title = "Edit"
            addButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "editSegue",
            let destination = segue.destination as? EditNotesViewController  else {
                return
        }
        
        if let row = tableView.indexPathForSelectedRow?.row {
            destination.note = storage.notes[row]
        }
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as! NotesTableViewCell
        let note = storage.notes[indexPath.row]
        
        cell.title.text = note.title
        cell.noteText.text = note.content
        cell.colorView.backgroundColor = note.color
        
            
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let uuid = storage.notes[indexPath.row].uid
            storage.remove(with: uuid)
            
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
}
