//
//  MyTitleTextView.swift
//  Note
//
//  Created by anca dev on 08/05/23.
//

import UIKit

class MyTitleTextView: UITextView {
    
    override func caretRect(for Position: UITextPosition) -> CGRect {
        let superCaret = super.caretRect(for: Position)
        
        return CGRect(x: superCaret.origin.x, y: 8, width: superCaret.width, height: 26)
    }
    
}
