//
//  NoteViewController.swift
//  Note
//
//  Created by anca dev on 02/05/23.
//

import UIKit

class NoteViewController: UIViewController {
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelText: UILabel!
    
    let dataFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    var noteItemArray = [NotesItem]()
    var noteEditTitle = ""
    var noteEditText = ""
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveNoteItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextView.delegate = self
        titleTextView.text = noteEditTitle
        
        textView.delegate = self
        textView.text = noteEditText
        
        if noteEditTitle != "" {
            labelTitle.isHidden = true
        }
        
        if noteEditText != "" {
            labelText.isHidden = true
        }
        
        loadNoteItem()
    }
    
    func saveNoteItem() {
        if titleTextView.text != "" && titleTextView.text != "" {
            let newNote = NotesItem()
            newNote.title = titleTextView.text
            newNote.text = textView.text
            noteItemArray.insert(newNote, at: 0)
            
            let enco = PropertyListEncoder()
            
            do {
                let data = try enco.encode(noteItemArray)
                try data.write(to: dataFile!)
            } catch {
                print(error)
            }
        }
    }
    
    func loadNoteItem() {
        if let data = try? Data(contentsOf: dataFile!) {
            let deco = PropertyListDecoder()
            
            do {
                noteItemArray = try deco.decode([NotesItem].self, from: data)
            } catch {
                print(error)
            }
        }
    }
    
}

extension NoteViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textViewDid: UITextView) {
        if titleTextView.text == "" {
            labelTitle.isHidden = false
        } else {
            labelTitle.isHidden = true
        }
        
        if textView.text == "" {
            labelText.isHidden = false
        } else {
            labelText.isHidden = true
        }
    }
    
}
