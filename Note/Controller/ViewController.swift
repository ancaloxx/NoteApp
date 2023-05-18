//
//  ViewController.swift
//  Note
//
//  Created by anca dev on 01/05/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableNotes: UITableView!
    @IBOutlet weak var itemCountText: UILabel!
    
    var notesArray = [NotesItem]()
    var noteItem = NotesItem()
    let dataFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    var checkboxCellSH = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadNoteItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFile)
        
        loadNoteItem()
        
        tableNotes.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "listCell")
        tableNotes.delegate = self
        tableNotes.dataSource = self
    }
    
    func loadNoteItem() {
        if let data = try? Data(contentsOf: dataFile!) {
            let deco = PropertyListDecoder()
            
            do {
                notesArray = try deco.decode([NotesItem].self, from: data)
                itemCountText.text = "\(notesArray.count) Items"
            } catch {
                print(error)
            }
        }
        
        tableNotes.reloadData()
    }
    
    func saveNoteItem() {
        let enco = PropertyListEncoder()
        
        do {
            let data = try enco.encode(self.notesArray)
            try data.write(to: dataFile!)
        } catch {
            print(error)
        }
    }


    @IBAction func pilihAct(_ sender: UIBarButtonItem) {
        checkboxCellSH = !checkboxCellSH
        sender.title = checkboxCellSH ? "Hapus" : "Pilih"
        
        loadNoteItem()
        notesArray.removeAll(where: { $0.delete == true})
        tableNotes.reloadData()
        saveNoteItem()
        
        print(notesArray)
        
        itemCountText.text = "\(notesArray.count) Items"
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListCell
        cell.titleText.text = notesArray[indexPath.row].title
        cell.secText.text = notesArray[indexPath.row].text
        cell.checkSH = !checkboxCellSH
        cell.cellRow = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.noteItem.title = notesArray[indexPath.row].title
        self.noteItem.text = notesArray[indexPath.row].text
        
        notesArray.remove(at: indexPath.row)
        
        self.saveNoteItem()
        
        self.performSegue(withIdentifier: "NoteEdit", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NoteEdit" {
            let nE = segue.destination as! NoteViewController
            nE.noteEditTitle = self.noteItem.title
            nE.noteEditText = self.noteItem.text
        }
    }
    
}

