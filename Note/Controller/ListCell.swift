//
//  ListCell.swift
//  Note
//
//  Created by anca dev on 01/05/23.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var secText: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var checkboxCell: UIButton!
    
    var checkBool = false
    var checkSH = false
    var cellRow = 0
    var notesArray = [NotesItem]()
    let dataFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        UIView.transition(with: checkboxCell, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.checkboxCell.isHidden = self.checkSH
        }, completion: nil)
        
        loadNoteItem()
    }
    
    @IBAction func checkBoxCellAct(_ sender: UIButton) {
        print(cellRow)
        if checkBool {
            UIView.transition(with: sender, duration: 0.3, options: .transitionCrossDissolve, animations: {
                sender.setImage(UIImage(systemName: "square"), for: .normal)
            }, completion: nil)
            
            checkBool = !checkBool
            notesArray[cellRow].delete = false
        } else {
            UIView.transition(with: sender, duration: 0.3, options: .transitionCrossDissolve, animations: {
                sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            }, completion: nil)
            
            checkBool = !checkBool
            notesArray[cellRow].delete = true
        }
        
        saveNoteItem()
    }
    
    func loadNoteItem() {
        if let data = try? Data(contentsOf: dataFile!) {
            let deco = PropertyListDecoder()
            
            do {
                notesArray = try deco.decode([NotesItem].self, from: data)
            } catch {
                print(error)
            }
        }
    }
    
    func saveNoteItem() {
        let enco = PropertyListEncoder()
        
        do {
            let data = try enco.encode(notesArray)
            try data.write(to: dataFile!)
        } catch {
            print(error)
        }
    }
}
